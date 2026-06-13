import 'package:flutter/foundation.dart';
import '../../domain/models/scan.dart';
import '../../domain/repositories/scan_repository.dart';
import '../datasources/scan_local_datasource.dart';
import '../datasources/scan_remote_datasource.dart';
import '../dtos/scan_mapper.dart';
import 'package:path/path.dart' as p;

class ScanRepositoryImpl implements ScanRepository {
  final ScanLocalDataSource _localDataSource;
  final ScanRemoteDataSource _remoteDataSource;

  ScanRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<Scan>> getScans() async {
    final localRows = await _localDataSource.getScans();
    return localRows.map((r) => r.toDomain()).toList();
  }

  @override
  Stream<List<Scan>> watchScans() {
    return _localDataSource.watchScans().map((list) {
      return list.map((r) => r.toDomain()).toList();
    });
  }

  @override
  Future<Scan?> getScanById(String id) async {
    final localRow = await _localDataSource.getScanById(id);
    return localRow?.toDomain();
  }

  @override
  Future<void> saveScan(Scan scan) async {
    // 1. Save locally with pending_insert status
    final localScan = scan.copyWith(syncStatus: SyncStatus.pendingInsert);
    // Construct local scan row
    final row = localScan.toDataClass();
    await _localDataSource.saveScan(row);

    // 2. Trigger async background synchronization (don't block the UI thread)
    _syncSingleScan(localScan).catchError((e) {
      // Offline/network failure; the scan record remains pendingInsert to be synced later
      debugPrint('Background sync failed for scan: ${scan.id}: $e');
    });
  }

  @override
  Future<void> deleteScan(String id) async {
    final scan = await getScanById(id);
    if (scan == null) return;

    // Always mark as pendingDelete and attempt remote cleanup — even for
    // pendingInsert records — to cover the race where background sync uploads
    // to remote between our status read and the delete.
    final updatedScan = scan.copyWith(syncStatus: SyncStatus.pendingDelete);
    await _localDataSource.saveScan(updatedScan.toDataClass());

    _deleteSingleScanRemote(id).catchError((e) {
      debugPrint('Background remote delete failed for scan: $id: $e');
    });
  }

  @override
  Future<List<Scan>> getPendingSyncScans() async {
    final pending = await _localDataSource.getPendingSyncScans();
    return pending.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> updateSyncStatus(String id, SyncStatus status, {String? remoteUrl}) async {
    await _localDataSource.updateSyncStatus(
      id,
      status.toMapString(),
      remoteUrl: remoteUrl,
    );
  }

  @override
  Future<void> syncWithRemote() async {
    final pending = await getPendingSyncScans();
    for (final scan in pending) {
      try {
        if (scan.syncStatus == SyncStatus.pendingInsert) {
          await _syncSingleScan(scan);
        } else if (scan.syncStatus == SyncStatus.pendingDelete) {
          await _deleteSingleScanRemote(scan.id);
        }
      } catch (e) {
        debugPrint('Error syncing scan ${scan.id}: $e');
        // Continue with other scans if one fails
      }
    }
  }

  Future<void> _syncSingleScan(Scan scan) async {
    try {
      String? remoteUrl = scan.imageRemoteUrl;

      // Upload local image file if not done yet
      if (remoteUrl == null || remoteUrl.isEmpty) {
        final ext = p.extension(scan.imageLocalPath);
        final fileName = '${scan.id}$ext';
        remoteUrl = await _remoteDataSource.uploadImage(scan.imageLocalPath, fileName);
      }

      // If remoteUrl is still null (e.g. no-op remote source), leave the scan as
      // pendingInsert so a real sync attempt can pick it up later.
      if (remoteUrl == null) return;

      // Update scan object with remote url and synced status
      final scanToUpload = scan.copyWith(
        imageRemoteUrl: remoteUrl,
        syncStatus: SyncStatus.synced,
      );

      // Upload the record to Supabase
      await _remoteDataSource.uploadScan(scanToUpload);

      // Save synced state locally
      await updateSyncStatus(scan.id, SyncStatus.synced, remoteUrl: remoteUrl);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _deleteSingleScanRemote(String id) async {
    // Delete locally first so the user's view is correct even if remote cleanup fails.
    await _localDataSource.deleteScan(id);
    await _remoteDataSource.deleteScan(id);
  }
}
