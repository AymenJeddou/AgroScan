import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DataClassName('CachedPest')
class CachedPests extends Table {
  TextColumn get id => text()();
  TextColumn get nameFr => text()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  TextColumn get scientificName => text()();
  TextColumn get order => text().withDefault(const Constant(''))();
  TextColumn get family => text().withDefault(const Constant(''))();
  TextColumn get dangerLevel => text()();
  TextColumn get affectedCrops => text()(); // Store as JSON string array
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  TextColumn get descriptionFr => text()();
  TextColumn get descriptionAr => text()();
  TextColumn get descriptionEn => text()();
  TextColumn get symptomsFr => text()(); // Store as JSON string array
  TextColumn get symptomsAr => text()(); // Store as JSON string array
  TextColumn get symptomsEn => text()(); // Store as JSON string array
  TextColumn get damageFr => text()();
  TextColumn get damageAr => text()();
  TextColumn get damageEn => text()();
  TextColumn get preventionFr => text()();
  TextColumn get preventionAr => text()();
  TextColumn get preventionEn => text()();
  TextColumn get biologicalTreatmentFr => text()();
  TextColumn get biologicalTreatmentAr => text()();
  TextColumn get biologicalTreatmentEn => text()();
  TextColumn get chemicalTreatmentFr => text()();
  TextColumn get chemicalTreatmentAr => text()();
  TextColumn get chemicalTreatmentEn => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LocalScan')
class Scans extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get pestId => text().nullable().references(CachedPests, #id)();
  TextColumn get cropType => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get imageLocalPath => text()();
  TextColumn get imageRemoteUrl => text().nullable()();
  RealColumn get confidenceScore => real()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FavoritePest')
class FavoritePests extends Table {
  TextColumn get pestId => text()();

  @override
  Set<Column> get primaryKey => {pestId};
}

@DriftDatabase(tables: [CachedPests, Scans, FavoritePests])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 3) {
        await m.drop(cachedPests);
        await m.createTable(cachedPests);
      }
      if (from < 4) {
        await m.createTable(favoritePests);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'agroscan.db'));
    return NativeDatabase.createInBackground(file);
  });
}
