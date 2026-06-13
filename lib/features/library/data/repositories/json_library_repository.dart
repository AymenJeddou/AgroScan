import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/pest.dart';
import '../../domain/repositories/library_repository.dart';

/// An implementation of [LibraryRepository] that reads pest data from a local
/// JSON asset file.
///
/// This repository acts as the single source of truth for pest information
/// in the app's current offline-first phase. It loads all data into an
/// in-memory cache on startup.
class JsonLibraryRepository implements LibraryRepository {
  List<Pest>? _cache;

  @override
  Future<void> seedOrUpdateCache() async {
    if (_cache != null) return; // Already seeded

    final jsonString = await rootBundle.loadString('assets/data/pests.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _cache = jsonList.map((json) => Pest.fromJson(json)).toList();
  }

  @override
  Future<List<Pest>> getPests() async {
    await _ensureCacheIsSeeded();
    return _cache!;
  }

  @override
  Future<List<Pest>> getPestsByCrop(String cropType) async {
    await _ensureCacheIsSeeded();
    if (cropType.isEmpty || cropType == 'all') {
      return _cache!;
    }
    return _cache!
        .where((pest) => pest.affectedCrops.contains(cropType))
        .toList();
  }

  @override
  Future<Pest?> getPestById(String id) async {
    await _ensureCacheIsSeeded();
    try {
      return _cache!.firstWhere((pest) => pest.id == id);
    } catch (e) {
      return null; // Not found
    }
  }

  /// A helper to ensure that the cache is loaded before any read operations.
  Future<void> _ensureCacheIsSeeded() async {
    if (_cache == null) {
      await seedOrUpdateCache();
    }
  }
}
