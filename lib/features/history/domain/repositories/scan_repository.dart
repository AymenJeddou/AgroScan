import '../models/scan.dart';

abstract class ScanRepository {
  /// Fetches all local scans.
  Future<List<Scan>> getScans();

  /// Watches all local scans reactively (emits new lists when changes occur).
  Stream<List<Scan>> watchScans();

  /// Fetches a specific scan by its ID.
  Future<Scan?> getScanById(String id);

  /// Saves a scan to the local database, setting sync status to pending.
  Future<void> saveScan(Scan scan);

  /// Deletes a scan from local storage or marks it for deletion.
  Future<void> deleteScan(String id);

  /// Fetches scans that are pending upload or delete synchronization.
  Future<List<Scan>> getPendingSyncScans();

  /// Updates the sync status and optional remote URL of a scan.
  Future<void> updateSyncStatus(String id, SyncStatus status, {String? remoteUrl});

  /// Synchronizes scans with Supabase.
  Future<void> syncWithRemote();
}
