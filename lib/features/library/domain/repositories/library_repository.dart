import '../models/pest.dart';

abstract class LibraryRepository {
  /// Fetches all pests available in the library.
  Future<List<Pest>> getPests();

  /// Fetches a specific pest by its ID.
  Future<Pest?> getPestById(String id);

  /// Fetches pests that affect a specific crop type (e.g., 'tomato' or 'pepper').
  Future<List<Pest>> getPestsByCrop(String cropType);

  /// Synchronizes or seeds the local database cache with the pests from assets/remote sources.
  Future<void> seedOrUpdateCache();
}
