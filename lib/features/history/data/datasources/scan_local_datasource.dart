import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

abstract class ScanLocalDataSource {
  Future<List<LocalScan>> getScans();
  Stream<List<LocalScan>> watchScans();
  Future<LocalScan?> getScanById(String id);
  Future<void> saveScan(LocalScan scan);
  Future<void> deleteScan(String id);
  Future<List<LocalScan>> getPendingSyncScans();
  Future<void> updateSyncStatus(String id, String status, {String? remoteUrl});
}

class ScanLocalDataSourceImpl implements ScanLocalDataSource {
  final AppDatabase _database;

  ScanLocalDataSourceImpl(this._database);

  @override
  Future<List<LocalScan>> getScans() {
    return (_database.select(_database.scans)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  @override
  Stream<List<LocalScan>> watchScans() {
    return (_database.select(_database.scans)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  @override
  Future<LocalScan?> getScanById(String id) {
    return (_database.select(_database.scans)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<void> saveScan(LocalScan scan) {
    return _database.into(_database.scans).insertOnConflictUpdate(scan);
  }

  @override
  Future<void> deleteScan(String id) {
    return (_database.delete(_database.scans)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<LocalScan>> getPendingSyncScans() {
    return (_database.select(_database.scans)
          ..where((t) => t.syncStatus.equals('synced').not()))
        .get();
  }

  @override
  Future<void> updateSyncStatus(String id, String status, {String? remoteUrl}) {
    return (_database.update(_database.scans)..where((t) => t.id.equals(id))).write(
      ScansCompanion(
        syncStatus: Value(status),
        imageRemoteUrl: remoteUrl != null ? Value(remoteUrl) : const Value.absent(),
      ),
    );
  }
}
