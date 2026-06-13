import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/scan.dart';

extension LocalScanMapper on LocalScan {
  Scan toDomain() {
    return Scan(
      id: id,
      userId: userId,
      pestId: pestId,
      cropType: cropType,
      notes: notes,
      imageLocalPath: imageLocalPath,
      imageRemoteUrl: imageRemoteUrl,
      confidenceScore: confidenceScore,
      createdAt: createdAt,
      syncStatus: SyncStatus.fromString(syncStatus),
    );
  }
}

extension ScanMapper on Scan {
  ScansCompanion toCompanion() {
    return ScansCompanion(
      id: Value(id),
      userId: Value(userId),
      pestId: Value(pestId),
      cropType: Value(cropType),
      notes: Value(notes),
      imageLocalPath: Value(imageLocalPath),
      imageRemoteUrl: Value(imageRemoteUrl),
      confidenceScore: Value(confidenceScore),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus.toMapString()),
    );
  }

  LocalScan toDataClass() {
    return LocalScan(
      id: id,
      userId: userId,
      pestId: pestId,
      cropType: cropType,
      notes: notes,
      imageLocalPath: imageLocalPath,
      imageRemoteUrl: imageRemoteUrl,
      confidenceScore: confidenceScore,
      createdAt: createdAt,
      syncStatus: syncStatus.toMapString(),
    );
  }
}
