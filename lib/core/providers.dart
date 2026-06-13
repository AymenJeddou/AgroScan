import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'database/app_database.dart';
import '../features/history/data/datasources/scan_local_datasource.dart';
import '../features/history/data/datasources/scan_remote_datasource.dart';
import '../features/history/data/repositories/scan_repository_impl.dart';
import '../features/history/domain/models/scan.dart';
import '../features/history/domain/repositories/scan_repository.dart';
import '../features/library/data/repositories/json_library_repository.dart';
import '../features/library/data/repositories/favorites_repository.dart';
import '../features/library/domain/repositories/library_repository.dart';
import '../features/scanning/data/repositories/gemini_inference_repository.dart';
import '../features/scanning/domain/repositories/ai_inference_repository.dart';
import 'config/gemini_config.dart';

/// Provides the active [Locale] for the application. Defaults to French.
final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));

/// Provides the active [ThemeMode]. Defaults to system.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// Provides the Gemini API Key. Used by the chatbot feature.
final geminiApiKeyProvider = Provider<String>((ref) {
  return GeminiConfig.apiKey;
});

/// Singleton Drift database instance, closed when the provider is disposed.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Provider for the pest library data repository (loads from local JSON asset).
final libraryRepositoryProvider = Provider<LibraryRepository>(
  (ref) => JsonLibraryRepository(),
);

/// Provider for the favorites repository (Drift-backed).
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository(ref.watch(appDatabaseProvider));
});

/// Stream of favorited pest IDs as a Set for O(1) lookup.
final favoriteIdsProvider = StreamProvider<Set<String>>((ref) {
  return ref.watch(favoritesRepositoryProvider).watchFavoriteIds();
});

/// Provider for the scan history data repository (Drift local + Supabase remote).
final scanRepositoryProvider = Provider<ScanRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final local = ScanLocalDataSourceImpl(db);
  final remote = _buildRemoteDataSource();
  return ScanRepositoryImpl(local, remote);
});

/// Provider for the AI inference repository (Gemini 2.5 Flash via HTTP).
final aiInferenceRepositoryProvider = Provider<AIInferenceRepository>((ref) {
  return GeminiInferenceRepository();
});

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

/// Returns a real Supabase-backed remote data source when Supabase has been
/// initialised (env vars present), otherwise falls back to a no-op so the app
/// works fully offline without crashing.
ScanRemoteDataSource _buildRemoteDataSource() {
  try {
    return ScanRemoteDataSourceImpl(Supabase.instance.client);
  } catch (_) {
    return _NoOpRemoteDataSource();
  }
}

class _NoOpRemoteDataSource implements ScanRemoteDataSource {
  @override
  Future<void> uploadScan(Scan scan) async {}

  @override
  Future<String?> uploadImage(String localPath, String fileName) async => null;

  @override
  Future<void> deleteScan(String id) async {}
}
