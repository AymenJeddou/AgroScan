import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/scan.dart';

abstract class ScanRemoteDataSource {
  Future<void> uploadScan(Scan scan);
  Future<String?> uploadImage(String localPath, String remoteFileName);
  Future<void> deleteScan(String id);
}

class ScanRemoteDataSourceImpl implements ScanRemoteDataSource {
  final SupabaseClient _supabaseClient;

  ScanRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<void> uploadScan(Scan scan) async {
    await _supabaseClient.from('scans').upsert(scan.toJson());
  }

  @override
  Future<String?> uploadImage(String localPath, String remoteFileName) async {
    final file = File(localPath);
    if (!await file.exists()) return null;

    final response = await _supabaseClient.storage.from('scan-images').upload(
          remoteFileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
    
    if (response.isEmpty) {
      throw Exception('Failed to upload image to Supabase');
    }

    return _supabaseClient.storage.from('scan-images').getPublicUrl(remoteFileName);
  }

  @override
  Future<void> deleteScan(String id) async {
    await _supabaseClient.from('scans').delete().eq('id', id);
  }
}
