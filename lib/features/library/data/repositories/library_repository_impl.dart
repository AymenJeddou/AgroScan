import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/pest.dart';
import '../../domain/repositories/library_repository.dart';
import '../dtos/pest_mapper.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final AppDatabase _database;

  LibraryRepositoryImpl(this._database);

  @override
  Future<List<Pest>> getPests() async {
    await seedOrUpdateCache();
    final cached = await _database.select(_database.cachedPests).get();
    return cached.map((p) => p.toDomain()).toList();
  }

  @override
  Future<Pest?> getPestById(String id) async {
    await seedOrUpdateCache();
    final query = _database.select(_database.cachedPests)
      ..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Pest>> getPestsByCrop(String cropType) async {
    await seedOrUpdateCache();
    final cached = await _database.select(_database.cachedPests).get();
    return cached
        .map((p) => p.toDomain())
        .where((pest) => pest.affectedCrops.contains(cropType.toLowerCase()))
        .toList();
  }

  @override
  Future<void> seedOrUpdateCache() async {
    final countQuery = _database.select(_database.cachedPests);
    final existingCount = (await countQuery.get()).length;

    if (existingCount == 0) {
      try {
        final jsonString = await rootBundle.loadString('assets/data/pests.json');
        final List<dynamic> jsonList = jsonDecode(jsonString) as List;
        final pests = jsonList.map((e) => Pest.fromJson(e as Map<String, dynamic>)).toList();

        await _database.batch((batch) {
          batch.insertAll(
            _database.cachedPests,
            pests.map((p) => p.toCompanion()).toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      } catch (e) {
        // Keep it silent or log properly in production-grade app
        // We can print/log it
        debugPrint('Error seeding pest database cache: $e');
      }
    }
  }
}
