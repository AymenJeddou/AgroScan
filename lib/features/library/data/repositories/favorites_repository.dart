import '../../../../core/database/app_database.dart';
import 'package:drift/drift.dart' show Value;

class FavoritesRepository {
  final AppDatabase _db;
  FavoritesRepository(this._db);

  Stream<Set<String>> watchFavoriteIds() {
    return _db.select(_db.favoritePests).watch().map(
          (rows) => rows.map((r) => r.pestId).toSet(),
        );
  }

  Future<void> toggleFavorite(String pestId) async {
    final existing = await (_db.select(_db.favoritePests)
          ..where((t) => t.pestId.equals(pestId)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.delete(_db.favoritePests)
            ..where((t) => t.pestId.equals(pestId)))
          .go();
    } else {
      await _db.into(_db.favoritePests).insert(
            FavoritePestsCompanion(pestId: Value(pestId)),
          );
    }
  }
}
