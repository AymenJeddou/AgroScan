// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedPestsTable extends CachedPests
    with TableInfo<$CachedPestsTable, CachedPest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
    'name_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _familyMeta = const VerificationMeta('family');
  @override
  late final GeneratedColumn<String> family = GeneratedColumn<String>(
    'family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dangerLevelMeta = const VerificationMeta(
    'dangerLevel',
  );
  @override
  late final GeneratedColumn<String> dangerLevel = GeneratedColumn<String>(
    'danger_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _affectedCropsMeta = const VerificationMeta(
    'affectedCrops',
  );
  @override
  late final GeneratedColumn<String> affectedCrops = GeneratedColumn<String>(
    'affected_crops',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionFrMeta = const VerificationMeta(
    'descriptionFr',
  );
  @override
  late final GeneratedColumn<String> descriptionFr = GeneratedColumn<String>(
    'description_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionArMeta = const VerificationMeta(
    'descriptionAr',
  );
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
    'description_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionEnMeta = const VerificationMeta(
    'descriptionEn',
  );
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
    'description_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomsFrMeta = const VerificationMeta(
    'symptomsFr',
  );
  @override
  late final GeneratedColumn<String> symptomsFr = GeneratedColumn<String>(
    'symptoms_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomsArMeta = const VerificationMeta(
    'symptomsAr',
  );
  @override
  late final GeneratedColumn<String> symptomsAr = GeneratedColumn<String>(
    'symptoms_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomsEnMeta = const VerificationMeta(
    'symptomsEn',
  );
  @override
  late final GeneratedColumn<String> symptomsEn = GeneratedColumn<String>(
    'symptoms_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageFrMeta = const VerificationMeta(
    'damageFr',
  );
  @override
  late final GeneratedColumn<String> damageFr = GeneratedColumn<String>(
    'damage_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageArMeta = const VerificationMeta(
    'damageAr',
  );
  @override
  late final GeneratedColumn<String> damageAr = GeneratedColumn<String>(
    'damage_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageEnMeta = const VerificationMeta(
    'damageEn',
  );
  @override
  late final GeneratedColumn<String> damageEn = GeneratedColumn<String>(
    'damage_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preventionFrMeta = const VerificationMeta(
    'preventionFr',
  );
  @override
  late final GeneratedColumn<String> preventionFr = GeneratedColumn<String>(
    'prevention_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preventionArMeta = const VerificationMeta(
    'preventionAr',
  );
  @override
  late final GeneratedColumn<String> preventionAr = GeneratedColumn<String>(
    'prevention_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preventionEnMeta = const VerificationMeta(
    'preventionEn',
  );
  @override
  late final GeneratedColumn<String> preventionEn = GeneratedColumn<String>(
    'prevention_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _biologicalTreatmentFrMeta =
      const VerificationMeta('biologicalTreatmentFr');
  @override
  late final GeneratedColumn<String> biologicalTreatmentFr =
      GeneratedColumn<String>(
        'biological_treatment_fr',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _biologicalTreatmentArMeta =
      const VerificationMeta('biologicalTreatmentAr');
  @override
  late final GeneratedColumn<String> biologicalTreatmentAr =
      GeneratedColumn<String>(
        'biological_treatment_ar',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _biologicalTreatmentEnMeta =
      const VerificationMeta('biologicalTreatmentEn');
  @override
  late final GeneratedColumn<String> biologicalTreatmentEn =
      GeneratedColumn<String>(
        'biological_treatment_en',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _chemicalTreatmentFrMeta =
      const VerificationMeta('chemicalTreatmentFr');
  @override
  late final GeneratedColumn<String> chemicalTreatmentFr =
      GeneratedColumn<String>(
        'chemical_treatment_fr',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _chemicalTreatmentArMeta =
      const VerificationMeta('chemicalTreatmentAr');
  @override
  late final GeneratedColumn<String> chemicalTreatmentAr =
      GeneratedColumn<String>(
        'chemical_treatment_ar',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _chemicalTreatmentEnMeta =
      const VerificationMeta('chemicalTreatmentEn');
  @override
  late final GeneratedColumn<String> chemicalTreatmentEn =
      GeneratedColumn<String>(
        'chemical_treatment_en',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameFr,
    nameAr,
    nameEn,
    scientificName,
    order,
    family,
    dangerLevel,
    affectedCrops,
    imageUrl,
    descriptionFr,
    descriptionAr,
    descriptionEn,
    symptomsFr,
    symptomsAr,
    symptomsEn,
    damageFr,
    damageAr,
    damageEn,
    preventionFr,
    preventionAr,
    preventionEn,
    biologicalTreatmentFr,
    biologicalTreatmentAr,
    biologicalTreatmentEn,
    chemicalTreatmentFr,
    chemicalTreatmentAr,
    chemicalTreatmentEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_pests';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedPest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_fr')) {
      context.handle(
        _nameFrMeta,
        nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta),
      );
    } else if (isInserting) {
      context.missing(_nameFrMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scientificNameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('family')) {
      context.handle(
        _familyMeta,
        family.isAcceptableOrUnknown(data['family']!, _familyMeta),
      );
    }
    if (data.containsKey('danger_level')) {
      context.handle(
        _dangerLevelMeta,
        dangerLevel.isAcceptableOrUnknown(
          data['danger_level']!,
          _dangerLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dangerLevelMeta);
    }
    if (data.containsKey('affected_crops')) {
      context.handle(
        _affectedCropsMeta,
        affectedCrops.isAcceptableOrUnknown(
          data['affected_crops']!,
          _affectedCropsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_affectedCropsMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('description_fr')) {
      context.handle(
        _descriptionFrMeta,
        descriptionFr.isAcceptableOrUnknown(
          data['description_fr']!,
          _descriptionFrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionFrMeta);
    }
    if (data.containsKey('description_ar')) {
      context.handle(
        _descriptionArMeta,
        descriptionAr.isAcceptableOrUnknown(
          data['description_ar']!,
          _descriptionArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionArMeta);
    }
    if (data.containsKey('description_en')) {
      context.handle(
        _descriptionEnMeta,
        descriptionEn.isAcceptableOrUnknown(
          data['description_en']!,
          _descriptionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionEnMeta);
    }
    if (data.containsKey('symptoms_fr')) {
      context.handle(
        _symptomsFrMeta,
        symptomsFr.isAcceptableOrUnknown(data['symptoms_fr']!, _symptomsFrMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomsFrMeta);
    }
    if (data.containsKey('symptoms_ar')) {
      context.handle(
        _symptomsArMeta,
        symptomsAr.isAcceptableOrUnknown(data['symptoms_ar']!, _symptomsArMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomsArMeta);
    }
    if (data.containsKey('symptoms_en')) {
      context.handle(
        _symptomsEnMeta,
        symptomsEn.isAcceptableOrUnknown(data['symptoms_en']!, _symptomsEnMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomsEnMeta);
    }
    if (data.containsKey('damage_fr')) {
      context.handle(
        _damageFrMeta,
        damageFr.isAcceptableOrUnknown(data['damage_fr']!, _damageFrMeta),
      );
    } else if (isInserting) {
      context.missing(_damageFrMeta);
    }
    if (data.containsKey('damage_ar')) {
      context.handle(
        _damageArMeta,
        damageAr.isAcceptableOrUnknown(data['damage_ar']!, _damageArMeta),
      );
    } else if (isInserting) {
      context.missing(_damageArMeta);
    }
    if (data.containsKey('damage_en')) {
      context.handle(
        _damageEnMeta,
        damageEn.isAcceptableOrUnknown(data['damage_en']!, _damageEnMeta),
      );
    } else if (isInserting) {
      context.missing(_damageEnMeta);
    }
    if (data.containsKey('prevention_fr')) {
      context.handle(
        _preventionFrMeta,
        preventionFr.isAcceptableOrUnknown(
          data['prevention_fr']!,
          _preventionFrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preventionFrMeta);
    }
    if (data.containsKey('prevention_ar')) {
      context.handle(
        _preventionArMeta,
        preventionAr.isAcceptableOrUnknown(
          data['prevention_ar']!,
          _preventionArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preventionArMeta);
    }
    if (data.containsKey('prevention_en')) {
      context.handle(
        _preventionEnMeta,
        preventionEn.isAcceptableOrUnknown(
          data['prevention_en']!,
          _preventionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preventionEnMeta);
    }
    if (data.containsKey('biological_treatment_fr')) {
      context.handle(
        _biologicalTreatmentFrMeta,
        biologicalTreatmentFr.isAcceptableOrUnknown(
          data['biological_treatment_fr']!,
          _biologicalTreatmentFrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_biologicalTreatmentFrMeta);
    }
    if (data.containsKey('biological_treatment_ar')) {
      context.handle(
        _biologicalTreatmentArMeta,
        biologicalTreatmentAr.isAcceptableOrUnknown(
          data['biological_treatment_ar']!,
          _biologicalTreatmentArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_biologicalTreatmentArMeta);
    }
    if (data.containsKey('biological_treatment_en')) {
      context.handle(
        _biologicalTreatmentEnMeta,
        biologicalTreatmentEn.isAcceptableOrUnknown(
          data['biological_treatment_en']!,
          _biologicalTreatmentEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_biologicalTreatmentEnMeta);
    }
    if (data.containsKey('chemical_treatment_fr')) {
      context.handle(
        _chemicalTreatmentFrMeta,
        chemicalTreatmentFr.isAcceptableOrUnknown(
          data['chemical_treatment_fr']!,
          _chemicalTreatmentFrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chemicalTreatmentFrMeta);
    }
    if (data.containsKey('chemical_treatment_ar')) {
      context.handle(
        _chemicalTreatmentArMeta,
        chemicalTreatmentAr.isAcceptableOrUnknown(
          data['chemical_treatment_ar']!,
          _chemicalTreatmentArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chemicalTreatmentArMeta);
    }
    if (data.containsKey('chemical_treatment_en')) {
      context.handle(
        _chemicalTreatmentEnMeta,
        chemicalTreatmentEn.isAcceptableOrUnknown(
          data['chemical_treatment_en']!,
          _chemicalTreatmentEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chemicalTreatmentEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedPest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_fr'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      scientificName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scientific_name'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order'],
      )!,
      family: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family'],
      )!,
      dangerLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}danger_level'],
      )!,
      affectedCrops: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}affected_crops'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      descriptionFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_fr'],
      )!,
      descriptionAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ar'],
      )!,
      descriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_en'],
      )!,
      symptomsFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms_fr'],
      )!,
      symptomsAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms_ar'],
      )!,
      symptomsEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms_en'],
      )!,
      damageFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_fr'],
      )!,
      damageAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_ar'],
      )!,
      damageEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_en'],
      )!,
      preventionFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prevention_fr'],
      )!,
      preventionAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prevention_ar'],
      )!,
      preventionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prevention_en'],
      )!,
      biologicalTreatmentFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biological_treatment_fr'],
      )!,
      biologicalTreatmentAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biological_treatment_ar'],
      )!,
      biologicalTreatmentEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biological_treatment_en'],
      )!,
      chemicalTreatmentFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chemical_treatment_fr'],
      )!,
      chemicalTreatmentAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chemical_treatment_ar'],
      )!,
      chemicalTreatmentEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chemical_treatment_en'],
      )!,
    );
  }

  @override
  $CachedPestsTable createAlias(String alias) {
    return $CachedPestsTable(attachedDatabase, alias);
  }
}

class CachedPest extends DataClass implements Insertable<CachedPest> {
  final String id;
  final String nameFr;
  final String nameAr;
  final String nameEn;
  final String scientificName;
  final String order;
  final String family;
  final String dangerLevel;
  final String affectedCrops;
  final String imageUrl;
  final String descriptionFr;
  final String descriptionAr;
  final String descriptionEn;
  final String symptomsFr;
  final String symptomsAr;
  final String symptomsEn;
  final String damageFr;
  final String damageAr;
  final String damageEn;
  final String preventionFr;
  final String preventionAr;
  final String preventionEn;
  final String biologicalTreatmentFr;
  final String biologicalTreatmentAr;
  final String biologicalTreatmentEn;
  final String chemicalTreatmentFr;
  final String chemicalTreatmentAr;
  final String chemicalTreatmentEn;
  const CachedPest({
    required this.id,
    required this.nameFr,
    required this.nameAr,
    required this.nameEn,
    required this.scientificName,
    required this.order,
    required this.family,
    required this.dangerLevel,
    required this.affectedCrops,
    required this.imageUrl,
    required this.descriptionFr,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.symptomsFr,
    required this.symptomsAr,
    required this.symptomsEn,
    required this.damageFr,
    required this.damageAr,
    required this.damageEn,
    required this.preventionFr,
    required this.preventionAr,
    required this.preventionEn,
    required this.biologicalTreatmentFr,
    required this.biologicalTreatmentAr,
    required this.biologicalTreatmentEn,
    required this.chemicalTreatmentFr,
    required this.chemicalTreatmentAr,
    required this.chemicalTreatmentEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_fr'] = Variable<String>(nameFr);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    map['scientific_name'] = Variable<String>(scientificName);
    map['order'] = Variable<String>(order);
    map['family'] = Variable<String>(family);
    map['danger_level'] = Variable<String>(dangerLevel);
    map['affected_crops'] = Variable<String>(affectedCrops);
    map['image_url'] = Variable<String>(imageUrl);
    map['description_fr'] = Variable<String>(descriptionFr);
    map['description_ar'] = Variable<String>(descriptionAr);
    map['description_en'] = Variable<String>(descriptionEn);
    map['symptoms_fr'] = Variable<String>(symptomsFr);
    map['symptoms_ar'] = Variable<String>(symptomsAr);
    map['symptoms_en'] = Variable<String>(symptomsEn);
    map['damage_fr'] = Variable<String>(damageFr);
    map['damage_ar'] = Variable<String>(damageAr);
    map['damage_en'] = Variable<String>(damageEn);
    map['prevention_fr'] = Variable<String>(preventionFr);
    map['prevention_ar'] = Variable<String>(preventionAr);
    map['prevention_en'] = Variable<String>(preventionEn);
    map['biological_treatment_fr'] = Variable<String>(biologicalTreatmentFr);
    map['biological_treatment_ar'] = Variable<String>(biologicalTreatmentAr);
    map['biological_treatment_en'] = Variable<String>(biologicalTreatmentEn);
    map['chemical_treatment_fr'] = Variable<String>(chemicalTreatmentFr);
    map['chemical_treatment_ar'] = Variable<String>(chemicalTreatmentAr);
    map['chemical_treatment_en'] = Variable<String>(chemicalTreatmentEn);
    return map;
  }

  CachedPestsCompanion toCompanion(bool nullToAbsent) {
    return CachedPestsCompanion(
      id: Value(id),
      nameFr: Value(nameFr),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      scientificName: Value(scientificName),
      order: Value(order),
      family: Value(family),
      dangerLevel: Value(dangerLevel),
      affectedCrops: Value(affectedCrops),
      imageUrl: Value(imageUrl),
      descriptionFr: Value(descriptionFr),
      descriptionAr: Value(descriptionAr),
      descriptionEn: Value(descriptionEn),
      symptomsFr: Value(symptomsFr),
      symptomsAr: Value(symptomsAr),
      symptomsEn: Value(symptomsEn),
      damageFr: Value(damageFr),
      damageAr: Value(damageAr),
      damageEn: Value(damageEn),
      preventionFr: Value(preventionFr),
      preventionAr: Value(preventionAr),
      preventionEn: Value(preventionEn),
      biologicalTreatmentFr: Value(biologicalTreatmentFr),
      biologicalTreatmentAr: Value(biologicalTreatmentAr),
      biologicalTreatmentEn: Value(biologicalTreatmentEn),
      chemicalTreatmentFr: Value(chemicalTreatmentFr),
      chemicalTreatmentAr: Value(chemicalTreatmentAr),
      chemicalTreatmentEn: Value(chemicalTreatmentEn),
    );
  }

  factory CachedPest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPest(
      id: serializer.fromJson<String>(json['id']),
      nameFr: serializer.fromJson<String>(json['nameFr']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      scientificName: serializer.fromJson<String>(json['scientificName']),
      order: serializer.fromJson<String>(json['order']),
      family: serializer.fromJson<String>(json['family']),
      dangerLevel: serializer.fromJson<String>(json['dangerLevel']),
      affectedCrops: serializer.fromJson<String>(json['affectedCrops']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      descriptionFr: serializer.fromJson<String>(json['descriptionFr']),
      descriptionAr: serializer.fromJson<String>(json['descriptionAr']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      symptomsFr: serializer.fromJson<String>(json['symptomsFr']),
      symptomsAr: serializer.fromJson<String>(json['symptomsAr']),
      symptomsEn: serializer.fromJson<String>(json['symptomsEn']),
      damageFr: serializer.fromJson<String>(json['damageFr']),
      damageAr: serializer.fromJson<String>(json['damageAr']),
      damageEn: serializer.fromJson<String>(json['damageEn']),
      preventionFr: serializer.fromJson<String>(json['preventionFr']),
      preventionAr: serializer.fromJson<String>(json['preventionAr']),
      preventionEn: serializer.fromJson<String>(json['preventionEn']),
      biologicalTreatmentFr: serializer.fromJson<String>(
        json['biologicalTreatmentFr'],
      ),
      biologicalTreatmentAr: serializer.fromJson<String>(
        json['biologicalTreatmentAr'],
      ),
      biologicalTreatmentEn: serializer.fromJson<String>(
        json['biologicalTreatmentEn'],
      ),
      chemicalTreatmentFr: serializer.fromJson<String>(
        json['chemicalTreatmentFr'],
      ),
      chemicalTreatmentAr: serializer.fromJson<String>(
        json['chemicalTreatmentAr'],
      ),
      chemicalTreatmentEn: serializer.fromJson<String>(
        json['chemicalTreatmentEn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameFr': serializer.toJson<String>(nameFr),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'scientificName': serializer.toJson<String>(scientificName),
      'order': serializer.toJson<String>(order),
      'family': serializer.toJson<String>(family),
      'dangerLevel': serializer.toJson<String>(dangerLevel),
      'affectedCrops': serializer.toJson<String>(affectedCrops),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'descriptionFr': serializer.toJson<String>(descriptionFr),
      'descriptionAr': serializer.toJson<String>(descriptionAr),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'symptomsFr': serializer.toJson<String>(symptomsFr),
      'symptomsAr': serializer.toJson<String>(symptomsAr),
      'symptomsEn': serializer.toJson<String>(symptomsEn),
      'damageFr': serializer.toJson<String>(damageFr),
      'damageAr': serializer.toJson<String>(damageAr),
      'damageEn': serializer.toJson<String>(damageEn),
      'preventionFr': serializer.toJson<String>(preventionFr),
      'preventionAr': serializer.toJson<String>(preventionAr),
      'preventionEn': serializer.toJson<String>(preventionEn),
      'biologicalTreatmentFr': serializer.toJson<String>(biologicalTreatmentFr),
      'biologicalTreatmentAr': serializer.toJson<String>(biologicalTreatmentAr),
      'biologicalTreatmentEn': serializer.toJson<String>(biologicalTreatmentEn),
      'chemicalTreatmentFr': serializer.toJson<String>(chemicalTreatmentFr),
      'chemicalTreatmentAr': serializer.toJson<String>(chemicalTreatmentAr),
      'chemicalTreatmentEn': serializer.toJson<String>(chemicalTreatmentEn),
    };
  }

  CachedPest copyWith({
    String? id,
    String? nameFr,
    String? nameAr,
    String? nameEn,
    String? scientificName,
    String? order,
    String? family,
    String? dangerLevel,
    String? affectedCrops,
    String? imageUrl,
    String? descriptionFr,
    String? descriptionAr,
    String? descriptionEn,
    String? symptomsFr,
    String? symptomsAr,
    String? symptomsEn,
    String? damageFr,
    String? damageAr,
    String? damageEn,
    String? preventionFr,
    String? preventionAr,
    String? preventionEn,
    String? biologicalTreatmentFr,
    String? biologicalTreatmentAr,
    String? biologicalTreatmentEn,
    String? chemicalTreatmentFr,
    String? chemicalTreatmentAr,
    String? chemicalTreatmentEn,
  }) => CachedPest(
    id: id ?? this.id,
    nameFr: nameFr ?? this.nameFr,
    nameAr: nameAr ?? this.nameAr,
    nameEn: nameEn ?? this.nameEn,
    scientificName: scientificName ?? this.scientificName,
    order: order ?? this.order,
    family: family ?? this.family,
    dangerLevel: dangerLevel ?? this.dangerLevel,
    affectedCrops: affectedCrops ?? this.affectedCrops,
    imageUrl: imageUrl ?? this.imageUrl,
    descriptionFr: descriptionFr ?? this.descriptionFr,
    descriptionAr: descriptionAr ?? this.descriptionAr,
    descriptionEn: descriptionEn ?? this.descriptionEn,
    symptomsFr: symptomsFr ?? this.symptomsFr,
    symptomsAr: symptomsAr ?? this.symptomsAr,
    symptomsEn: symptomsEn ?? this.symptomsEn,
    damageFr: damageFr ?? this.damageFr,
    damageAr: damageAr ?? this.damageAr,
    damageEn: damageEn ?? this.damageEn,
    preventionFr: preventionFr ?? this.preventionFr,
    preventionAr: preventionAr ?? this.preventionAr,
    preventionEn: preventionEn ?? this.preventionEn,
    biologicalTreatmentFr: biologicalTreatmentFr ?? this.biologicalTreatmentFr,
    biologicalTreatmentAr: biologicalTreatmentAr ?? this.biologicalTreatmentAr,
    biologicalTreatmentEn: biologicalTreatmentEn ?? this.biologicalTreatmentEn,
    chemicalTreatmentFr: chemicalTreatmentFr ?? this.chemicalTreatmentFr,
    chemicalTreatmentAr: chemicalTreatmentAr ?? this.chemicalTreatmentAr,
    chemicalTreatmentEn: chemicalTreatmentEn ?? this.chemicalTreatmentEn,
  );
  CachedPest copyWithCompanion(CachedPestsCompanion data) {
    return CachedPest(
      id: data.id.present ? data.id.value : this.id,
      nameFr: data.nameFr.present ? data.nameFr.value : this.nameFr,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      order: data.order.present ? data.order.value : this.order,
      family: data.family.present ? data.family.value : this.family,
      dangerLevel: data.dangerLevel.present
          ? data.dangerLevel.value
          : this.dangerLevel,
      affectedCrops: data.affectedCrops.present
          ? data.affectedCrops.value
          : this.affectedCrops,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      descriptionFr: data.descriptionFr.present
          ? data.descriptionFr.value
          : this.descriptionFr,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      symptomsFr: data.symptomsFr.present
          ? data.symptomsFr.value
          : this.symptomsFr,
      symptomsAr: data.symptomsAr.present
          ? data.symptomsAr.value
          : this.symptomsAr,
      symptomsEn: data.symptomsEn.present
          ? data.symptomsEn.value
          : this.symptomsEn,
      damageFr: data.damageFr.present ? data.damageFr.value : this.damageFr,
      damageAr: data.damageAr.present ? data.damageAr.value : this.damageAr,
      damageEn: data.damageEn.present ? data.damageEn.value : this.damageEn,
      preventionFr: data.preventionFr.present
          ? data.preventionFr.value
          : this.preventionFr,
      preventionAr: data.preventionAr.present
          ? data.preventionAr.value
          : this.preventionAr,
      preventionEn: data.preventionEn.present
          ? data.preventionEn.value
          : this.preventionEn,
      biologicalTreatmentFr: data.biologicalTreatmentFr.present
          ? data.biologicalTreatmentFr.value
          : this.biologicalTreatmentFr,
      biologicalTreatmentAr: data.biologicalTreatmentAr.present
          ? data.biologicalTreatmentAr.value
          : this.biologicalTreatmentAr,
      biologicalTreatmentEn: data.biologicalTreatmentEn.present
          ? data.biologicalTreatmentEn.value
          : this.biologicalTreatmentEn,
      chemicalTreatmentFr: data.chemicalTreatmentFr.present
          ? data.chemicalTreatmentFr.value
          : this.chemicalTreatmentFr,
      chemicalTreatmentAr: data.chemicalTreatmentAr.present
          ? data.chemicalTreatmentAr.value
          : this.chemicalTreatmentAr,
      chemicalTreatmentEn: data.chemicalTreatmentEn.present
          ? data.chemicalTreatmentEn.value
          : this.chemicalTreatmentEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPest(')
          ..write('id: $id, ')
          ..write('nameFr: $nameFr, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('scientificName: $scientificName, ')
          ..write('order: $order, ')
          ..write('family: $family, ')
          ..write('dangerLevel: $dangerLevel, ')
          ..write('affectedCrops: $affectedCrops, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('descriptionFr: $descriptionFr, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('symptomsFr: $symptomsFr, ')
          ..write('symptomsAr: $symptomsAr, ')
          ..write('symptomsEn: $symptomsEn, ')
          ..write('damageFr: $damageFr, ')
          ..write('damageAr: $damageAr, ')
          ..write('damageEn: $damageEn, ')
          ..write('preventionFr: $preventionFr, ')
          ..write('preventionAr: $preventionAr, ')
          ..write('preventionEn: $preventionEn, ')
          ..write('biologicalTreatmentFr: $biologicalTreatmentFr, ')
          ..write('biologicalTreatmentAr: $biologicalTreatmentAr, ')
          ..write('biologicalTreatmentEn: $biologicalTreatmentEn, ')
          ..write('chemicalTreatmentFr: $chemicalTreatmentFr, ')
          ..write('chemicalTreatmentAr: $chemicalTreatmentAr, ')
          ..write('chemicalTreatmentEn: $chemicalTreatmentEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    nameFr,
    nameAr,
    nameEn,
    scientificName,
    order,
    family,
    dangerLevel,
    affectedCrops,
    imageUrl,
    descriptionFr,
    descriptionAr,
    descriptionEn,
    symptomsFr,
    symptomsAr,
    symptomsEn,
    damageFr,
    damageAr,
    damageEn,
    preventionFr,
    preventionAr,
    preventionEn,
    biologicalTreatmentFr,
    biologicalTreatmentAr,
    biologicalTreatmentEn,
    chemicalTreatmentFr,
    chemicalTreatmentAr,
    chemicalTreatmentEn,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPest &&
          other.id == this.id &&
          other.nameFr == this.nameFr &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.scientificName == this.scientificName &&
          other.order == this.order &&
          other.family == this.family &&
          other.dangerLevel == this.dangerLevel &&
          other.affectedCrops == this.affectedCrops &&
          other.imageUrl == this.imageUrl &&
          other.descriptionFr == this.descriptionFr &&
          other.descriptionAr == this.descriptionAr &&
          other.descriptionEn == this.descriptionEn &&
          other.symptomsFr == this.symptomsFr &&
          other.symptomsAr == this.symptomsAr &&
          other.symptomsEn == this.symptomsEn &&
          other.damageFr == this.damageFr &&
          other.damageAr == this.damageAr &&
          other.damageEn == this.damageEn &&
          other.preventionFr == this.preventionFr &&
          other.preventionAr == this.preventionAr &&
          other.preventionEn == this.preventionEn &&
          other.biologicalTreatmentFr == this.biologicalTreatmentFr &&
          other.biologicalTreatmentAr == this.biologicalTreatmentAr &&
          other.biologicalTreatmentEn == this.biologicalTreatmentEn &&
          other.chemicalTreatmentFr == this.chemicalTreatmentFr &&
          other.chemicalTreatmentAr == this.chemicalTreatmentAr &&
          other.chemicalTreatmentEn == this.chemicalTreatmentEn);
}

class CachedPestsCompanion extends UpdateCompanion<CachedPest> {
  final Value<String> id;
  final Value<String> nameFr;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<String> scientificName;
  final Value<String> order;
  final Value<String> family;
  final Value<String> dangerLevel;
  final Value<String> affectedCrops;
  final Value<String> imageUrl;
  final Value<String> descriptionFr;
  final Value<String> descriptionAr;
  final Value<String> descriptionEn;
  final Value<String> symptomsFr;
  final Value<String> symptomsAr;
  final Value<String> symptomsEn;
  final Value<String> damageFr;
  final Value<String> damageAr;
  final Value<String> damageEn;
  final Value<String> preventionFr;
  final Value<String> preventionAr;
  final Value<String> preventionEn;
  final Value<String> biologicalTreatmentFr;
  final Value<String> biologicalTreatmentAr;
  final Value<String> biologicalTreatmentEn;
  final Value<String> chemicalTreatmentFr;
  final Value<String> chemicalTreatmentAr;
  final Value<String> chemicalTreatmentEn;
  final Value<int> rowid;
  const CachedPestsCompanion({
    this.id = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.order = const Value.absent(),
    this.family = const Value.absent(),
    this.dangerLevel = const Value.absent(),
    this.affectedCrops = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.descriptionFr = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.symptomsFr = const Value.absent(),
    this.symptomsAr = const Value.absent(),
    this.symptomsEn = const Value.absent(),
    this.damageFr = const Value.absent(),
    this.damageAr = const Value.absent(),
    this.damageEn = const Value.absent(),
    this.preventionFr = const Value.absent(),
    this.preventionAr = const Value.absent(),
    this.preventionEn = const Value.absent(),
    this.biologicalTreatmentFr = const Value.absent(),
    this.biologicalTreatmentAr = const Value.absent(),
    this.biologicalTreatmentEn = const Value.absent(),
    this.chemicalTreatmentFr = const Value.absent(),
    this.chemicalTreatmentAr = const Value.absent(),
    this.chemicalTreatmentEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedPestsCompanion.insert({
    required String id,
    required String nameFr,
    required String nameAr,
    required String nameEn,
    required String scientificName,
    this.order = const Value.absent(),
    this.family = const Value.absent(),
    required String dangerLevel,
    required String affectedCrops,
    this.imageUrl = const Value.absent(),
    required String descriptionFr,
    required String descriptionAr,
    required String descriptionEn,
    required String symptomsFr,
    required String symptomsAr,
    required String symptomsEn,
    required String damageFr,
    required String damageAr,
    required String damageEn,
    required String preventionFr,
    required String preventionAr,
    required String preventionEn,
    required String biologicalTreatmentFr,
    required String biologicalTreatmentAr,
    required String biologicalTreatmentEn,
    required String chemicalTreatmentFr,
    required String chemicalTreatmentAr,
    required String chemicalTreatmentEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameFr = Value(nameFr),
       nameAr = Value(nameAr),
       nameEn = Value(nameEn),
       scientificName = Value(scientificName),
       dangerLevel = Value(dangerLevel),
       affectedCrops = Value(affectedCrops),
       descriptionFr = Value(descriptionFr),
       descriptionAr = Value(descriptionAr),
       descriptionEn = Value(descriptionEn),
       symptomsFr = Value(symptomsFr),
       symptomsAr = Value(symptomsAr),
       symptomsEn = Value(symptomsEn),
       damageFr = Value(damageFr),
       damageAr = Value(damageAr),
       damageEn = Value(damageEn),
       preventionFr = Value(preventionFr),
       preventionAr = Value(preventionAr),
       preventionEn = Value(preventionEn),
       biologicalTreatmentFr = Value(biologicalTreatmentFr),
       biologicalTreatmentAr = Value(biologicalTreatmentAr),
       biologicalTreatmentEn = Value(biologicalTreatmentEn),
       chemicalTreatmentFr = Value(chemicalTreatmentFr),
       chemicalTreatmentAr = Value(chemicalTreatmentAr),
       chemicalTreatmentEn = Value(chemicalTreatmentEn);
  static Insertable<CachedPest> custom({
    Expression<String>? id,
    Expression<String>? nameFr,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? scientificName,
    Expression<String>? order,
    Expression<String>? family,
    Expression<String>? dangerLevel,
    Expression<String>? affectedCrops,
    Expression<String>? imageUrl,
    Expression<String>? descriptionFr,
    Expression<String>? descriptionAr,
    Expression<String>? descriptionEn,
    Expression<String>? symptomsFr,
    Expression<String>? symptomsAr,
    Expression<String>? symptomsEn,
    Expression<String>? damageFr,
    Expression<String>? damageAr,
    Expression<String>? damageEn,
    Expression<String>? preventionFr,
    Expression<String>? preventionAr,
    Expression<String>? preventionEn,
    Expression<String>? biologicalTreatmentFr,
    Expression<String>? biologicalTreatmentAr,
    Expression<String>? biologicalTreatmentEn,
    Expression<String>? chemicalTreatmentFr,
    Expression<String>? chemicalTreatmentAr,
    Expression<String>? chemicalTreatmentEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameFr != null) 'name_fr': nameFr,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (scientificName != null) 'scientific_name': scientificName,
      if (order != null) 'order': order,
      if (family != null) 'family': family,
      if (dangerLevel != null) 'danger_level': dangerLevel,
      if (affectedCrops != null) 'affected_crops': affectedCrops,
      if (imageUrl != null) 'image_url': imageUrl,
      if (descriptionFr != null) 'description_fr': descriptionFr,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (symptomsFr != null) 'symptoms_fr': symptomsFr,
      if (symptomsAr != null) 'symptoms_ar': symptomsAr,
      if (symptomsEn != null) 'symptoms_en': symptomsEn,
      if (damageFr != null) 'damage_fr': damageFr,
      if (damageAr != null) 'damage_ar': damageAr,
      if (damageEn != null) 'damage_en': damageEn,
      if (preventionFr != null) 'prevention_fr': preventionFr,
      if (preventionAr != null) 'prevention_ar': preventionAr,
      if (preventionEn != null) 'prevention_en': preventionEn,
      if (biologicalTreatmentFr != null)
        'biological_treatment_fr': biologicalTreatmentFr,
      if (biologicalTreatmentAr != null)
        'biological_treatment_ar': biologicalTreatmentAr,
      if (biologicalTreatmentEn != null)
        'biological_treatment_en': biologicalTreatmentEn,
      if (chemicalTreatmentFr != null)
        'chemical_treatment_fr': chemicalTreatmentFr,
      if (chemicalTreatmentAr != null)
        'chemical_treatment_ar': chemicalTreatmentAr,
      if (chemicalTreatmentEn != null)
        'chemical_treatment_en': chemicalTreatmentEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPestsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameFr,
    Value<String>? nameAr,
    Value<String>? nameEn,
    Value<String>? scientificName,
    Value<String>? order,
    Value<String>? family,
    Value<String>? dangerLevel,
    Value<String>? affectedCrops,
    Value<String>? imageUrl,
    Value<String>? descriptionFr,
    Value<String>? descriptionAr,
    Value<String>? descriptionEn,
    Value<String>? symptomsFr,
    Value<String>? symptomsAr,
    Value<String>? symptomsEn,
    Value<String>? damageFr,
    Value<String>? damageAr,
    Value<String>? damageEn,
    Value<String>? preventionFr,
    Value<String>? preventionAr,
    Value<String>? preventionEn,
    Value<String>? biologicalTreatmentFr,
    Value<String>? biologicalTreatmentAr,
    Value<String>? biologicalTreatmentEn,
    Value<String>? chemicalTreatmentFr,
    Value<String>? chemicalTreatmentAr,
    Value<String>? chemicalTreatmentEn,
    Value<int>? rowid,
  }) {
    return CachedPestsCompanion(
      id: id ?? this.id,
      nameFr: nameFr ?? this.nameFr,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      scientificName: scientificName ?? this.scientificName,
      order: order ?? this.order,
      family: family ?? this.family,
      dangerLevel: dangerLevel ?? this.dangerLevel,
      affectedCrops: affectedCrops ?? this.affectedCrops,
      imageUrl: imageUrl ?? this.imageUrl,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      symptomsFr: symptomsFr ?? this.symptomsFr,
      symptomsAr: symptomsAr ?? this.symptomsAr,
      symptomsEn: symptomsEn ?? this.symptomsEn,
      damageFr: damageFr ?? this.damageFr,
      damageAr: damageAr ?? this.damageAr,
      damageEn: damageEn ?? this.damageEn,
      preventionFr: preventionFr ?? this.preventionFr,
      preventionAr: preventionAr ?? this.preventionAr,
      preventionEn: preventionEn ?? this.preventionEn,
      biologicalTreatmentFr:
          biologicalTreatmentFr ?? this.biologicalTreatmentFr,
      biologicalTreatmentAr:
          biologicalTreatmentAr ?? this.biologicalTreatmentAr,
      biologicalTreatmentEn:
          biologicalTreatmentEn ?? this.biologicalTreatmentEn,
      chemicalTreatmentFr: chemicalTreatmentFr ?? this.chemicalTreatmentFr,
      chemicalTreatmentAr: chemicalTreatmentAr ?? this.chemicalTreatmentAr,
      chemicalTreatmentEn: chemicalTreatmentEn ?? this.chemicalTreatmentEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (family.present) {
      map['family'] = Variable<String>(family.value);
    }
    if (dangerLevel.present) {
      map['danger_level'] = Variable<String>(dangerLevel.value);
    }
    if (affectedCrops.present) {
      map['affected_crops'] = Variable<String>(affectedCrops.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (descriptionFr.present) {
      map['description_fr'] = Variable<String>(descriptionFr.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (symptomsFr.present) {
      map['symptoms_fr'] = Variable<String>(symptomsFr.value);
    }
    if (symptomsAr.present) {
      map['symptoms_ar'] = Variable<String>(symptomsAr.value);
    }
    if (symptomsEn.present) {
      map['symptoms_en'] = Variable<String>(symptomsEn.value);
    }
    if (damageFr.present) {
      map['damage_fr'] = Variable<String>(damageFr.value);
    }
    if (damageAr.present) {
      map['damage_ar'] = Variable<String>(damageAr.value);
    }
    if (damageEn.present) {
      map['damage_en'] = Variable<String>(damageEn.value);
    }
    if (preventionFr.present) {
      map['prevention_fr'] = Variable<String>(preventionFr.value);
    }
    if (preventionAr.present) {
      map['prevention_ar'] = Variable<String>(preventionAr.value);
    }
    if (preventionEn.present) {
      map['prevention_en'] = Variable<String>(preventionEn.value);
    }
    if (biologicalTreatmentFr.present) {
      map['biological_treatment_fr'] = Variable<String>(
        biologicalTreatmentFr.value,
      );
    }
    if (biologicalTreatmentAr.present) {
      map['biological_treatment_ar'] = Variable<String>(
        biologicalTreatmentAr.value,
      );
    }
    if (biologicalTreatmentEn.present) {
      map['biological_treatment_en'] = Variable<String>(
        biologicalTreatmentEn.value,
      );
    }
    if (chemicalTreatmentFr.present) {
      map['chemical_treatment_fr'] = Variable<String>(
        chemicalTreatmentFr.value,
      );
    }
    if (chemicalTreatmentAr.present) {
      map['chemical_treatment_ar'] = Variable<String>(
        chemicalTreatmentAr.value,
      );
    }
    if (chemicalTreatmentEn.present) {
      map['chemical_treatment_en'] = Variable<String>(
        chemicalTreatmentEn.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPestsCompanion(')
          ..write('id: $id, ')
          ..write('nameFr: $nameFr, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('scientificName: $scientificName, ')
          ..write('order: $order, ')
          ..write('family: $family, ')
          ..write('dangerLevel: $dangerLevel, ')
          ..write('affectedCrops: $affectedCrops, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('descriptionFr: $descriptionFr, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('symptomsFr: $symptomsFr, ')
          ..write('symptomsAr: $symptomsAr, ')
          ..write('symptomsEn: $symptomsEn, ')
          ..write('damageFr: $damageFr, ')
          ..write('damageAr: $damageAr, ')
          ..write('damageEn: $damageEn, ')
          ..write('preventionFr: $preventionFr, ')
          ..write('preventionAr: $preventionAr, ')
          ..write('preventionEn: $preventionEn, ')
          ..write('biologicalTreatmentFr: $biologicalTreatmentFr, ')
          ..write('biologicalTreatmentAr: $biologicalTreatmentAr, ')
          ..write('biologicalTreatmentEn: $biologicalTreatmentEn, ')
          ..write('chemicalTreatmentFr: $chemicalTreatmentFr, ')
          ..write('chemicalTreatmentAr: $chemicalTreatmentAr, ')
          ..write('chemicalTreatmentEn: $chemicalTreatmentEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScansTable extends Scans with TableInfo<$ScansTable, LocalScan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pestIdMeta = const VerificationMeta('pestId');
  @override
  late final GeneratedColumn<String> pestId = GeneratedColumn<String>(
    'pest_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cached_pests (id)',
    ),
  );
  static const VerificationMeta _cropTypeMeta = const VerificationMeta(
    'cropType',
  );
  @override
  late final GeneratedColumn<String> cropType = GeneratedColumn<String>(
    'crop_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageLocalPathMeta = const VerificationMeta(
    'imageLocalPath',
  );
  @override
  late final GeneratedColumn<String> imageLocalPath = GeneratedColumn<String>(
    'image_local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageRemoteUrlMeta = const VerificationMeta(
    'imageRemoteUrl',
  );
  @override
  late final GeneratedColumn<String> imageRemoteUrl = GeneratedColumn<String>(
    'image_remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceScoreMeta = const VerificationMeta(
    'confidenceScore',
  );
  @override
  late final GeneratedColumn<double> confidenceScore = GeneratedColumn<double>(
    'confidence_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    pestId,
    cropType,
    notes,
    imageLocalPath,
    imageRemoteUrl,
    confidenceScore,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalScan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('pest_id')) {
      context.handle(
        _pestIdMeta,
        pestId.isAcceptableOrUnknown(data['pest_id']!, _pestIdMeta),
      );
    }
    if (data.containsKey('crop_type')) {
      context.handle(
        _cropTypeMeta,
        cropType.isAcceptableOrUnknown(data['crop_type']!, _cropTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_cropTypeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('image_local_path')) {
      context.handle(
        _imageLocalPathMeta,
        imageLocalPath.isAcceptableOrUnknown(
          data['image_local_path']!,
          _imageLocalPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_imageLocalPathMeta);
    }
    if (data.containsKey('image_remote_url')) {
      context.handle(
        _imageRemoteUrlMeta,
        imageRemoteUrl.isAcceptableOrUnknown(
          data['image_remote_url']!,
          _imageRemoteUrlMeta,
        ),
      );
    }
    if (data.containsKey('confidence_score')) {
      context.handle(
        _confidenceScoreMeta,
        confidenceScore.isAcceptableOrUnknown(
          data['confidence_score']!,
          _confidenceScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confidenceScoreMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalScan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalScan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      pestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pest_id'],
      ),
      cropType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crop_type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      imageLocalPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_local_path'],
      )!,
      imageRemoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_remote_url'],
      ),
      confidenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence_score'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $ScansTable createAlias(String alias) {
    return $ScansTable(attachedDatabase, alias);
  }
}

class LocalScan extends DataClass implements Insertable<LocalScan> {
  final String id;
  final String? userId;
  final String? pestId;
  final String cropType;
  final String? notes;
  final String imageLocalPath;
  final String? imageRemoteUrl;
  final double confidenceScore;
  final DateTime createdAt;
  final String syncStatus;
  const LocalScan({
    required this.id,
    this.userId,
    this.pestId,
    required this.cropType,
    this.notes,
    required this.imageLocalPath,
    this.imageRemoteUrl,
    required this.confidenceScore,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || pestId != null) {
      map['pest_id'] = Variable<String>(pestId);
    }
    map['crop_type'] = Variable<String>(cropType);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['image_local_path'] = Variable<String>(imageLocalPath);
    if (!nullToAbsent || imageRemoteUrl != null) {
      map['image_remote_url'] = Variable<String>(imageRemoteUrl);
    }
    map['confidence_score'] = Variable<double>(confidenceScore);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  ScansCompanion toCompanion(bool nullToAbsent) {
    return ScansCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      pestId: pestId == null && nullToAbsent
          ? const Value.absent()
          : Value(pestId),
      cropType: Value(cropType),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      imageLocalPath: Value(imageLocalPath),
      imageRemoteUrl: imageRemoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageRemoteUrl),
      confidenceScore: Value(confidenceScore),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalScan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalScan(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      pestId: serializer.fromJson<String?>(json['pestId']),
      cropType: serializer.fromJson<String>(json['cropType']),
      notes: serializer.fromJson<String?>(json['notes']),
      imageLocalPath: serializer.fromJson<String>(json['imageLocalPath']),
      imageRemoteUrl: serializer.fromJson<String?>(json['imageRemoteUrl']),
      confidenceScore: serializer.fromJson<double>(json['confidenceScore']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'pestId': serializer.toJson<String?>(pestId),
      'cropType': serializer.toJson<String>(cropType),
      'notes': serializer.toJson<String?>(notes),
      'imageLocalPath': serializer.toJson<String>(imageLocalPath),
      'imageRemoteUrl': serializer.toJson<String?>(imageRemoteUrl),
      'confidenceScore': serializer.toJson<double>(confidenceScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalScan copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    Value<String?> pestId = const Value.absent(),
    String? cropType,
    Value<String?> notes = const Value.absent(),
    String? imageLocalPath,
    Value<String?> imageRemoteUrl = const Value.absent(),
    double? confidenceScore,
    DateTime? createdAt,
    String? syncStatus,
  }) => LocalScan(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    pestId: pestId.present ? pestId.value : this.pestId,
    cropType: cropType ?? this.cropType,
    notes: notes.present ? notes.value : this.notes,
    imageLocalPath: imageLocalPath ?? this.imageLocalPath,
    imageRemoteUrl: imageRemoteUrl.present
        ? imageRemoteUrl.value
        : this.imageRemoteUrl,
    confidenceScore: confidenceScore ?? this.confidenceScore,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalScan copyWithCompanion(ScansCompanion data) {
    return LocalScan(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      pestId: data.pestId.present ? data.pestId.value : this.pestId,
      cropType: data.cropType.present ? data.cropType.value : this.cropType,
      notes: data.notes.present ? data.notes.value : this.notes,
      imageLocalPath: data.imageLocalPath.present
          ? data.imageLocalPath.value
          : this.imageLocalPath,
      imageRemoteUrl: data.imageRemoteUrl.present
          ? data.imageRemoteUrl.value
          : this.imageRemoteUrl,
      confidenceScore: data.confidenceScore.present
          ? data.confidenceScore.value
          : this.confidenceScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalScan(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('pestId: $pestId, ')
          ..write('cropType: $cropType, ')
          ..write('notes: $notes, ')
          ..write('imageLocalPath: $imageLocalPath, ')
          ..write('imageRemoteUrl: $imageRemoteUrl, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    pestId,
    cropType,
    notes,
    imageLocalPath,
    imageRemoteUrl,
    confidenceScore,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalScan &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.pestId == this.pestId &&
          other.cropType == this.cropType &&
          other.notes == this.notes &&
          other.imageLocalPath == this.imageLocalPath &&
          other.imageRemoteUrl == this.imageRemoteUrl &&
          other.confidenceScore == this.confidenceScore &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class ScansCompanion extends UpdateCompanion<LocalScan> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> pestId;
  final Value<String> cropType;
  final Value<String?> notes;
  final Value<String> imageLocalPath;
  final Value<String?> imageRemoteUrl;
  final Value<double> confidenceScore;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const ScansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.pestId = const Value.absent(),
    this.cropType = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageLocalPath = const Value.absent(),
    this.imageRemoteUrl = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScansCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    this.pestId = const Value.absent(),
    required String cropType,
    this.notes = const Value.absent(),
    required String imageLocalPath,
    this.imageRemoteUrl = const Value.absent(),
    required double confidenceScore,
    required DateTime createdAt,
    required String syncStatus,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cropType = Value(cropType),
       imageLocalPath = Value(imageLocalPath),
       confidenceScore = Value(confidenceScore),
       createdAt = Value(createdAt),
       syncStatus = Value(syncStatus);
  static Insertable<LocalScan> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? pestId,
    Expression<String>? cropType,
    Expression<String>? notes,
    Expression<String>? imageLocalPath,
    Expression<String>? imageRemoteUrl,
    Expression<double>? confidenceScore,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (pestId != null) 'pest_id': pestId,
      if (cropType != null) 'crop_type': cropType,
      if (notes != null) 'notes': notes,
      if (imageLocalPath != null) 'image_local_path': imageLocalPath,
      if (imageRemoteUrl != null) 'image_remote_url': imageRemoteUrl,
      if (confidenceScore != null) 'confidence_score': confidenceScore,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScansCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String?>? pestId,
    Value<String>? cropType,
    Value<String?>? notes,
    Value<String>? imageLocalPath,
    Value<String?>? imageRemoteUrl,
    Value<double>? confidenceScore,
    Value<DateTime>? createdAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return ScansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      pestId: pestId ?? this.pestId,
      cropType: cropType ?? this.cropType,
      notes: notes ?? this.notes,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      imageRemoteUrl: imageRemoteUrl ?? this.imageRemoteUrl,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (pestId.present) {
      map['pest_id'] = Variable<String>(pestId.value);
    }
    if (cropType.present) {
      map['crop_type'] = Variable<String>(cropType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imageLocalPath.present) {
      map['image_local_path'] = Variable<String>(imageLocalPath.value);
    }
    if (imageRemoteUrl.present) {
      map['image_remote_url'] = Variable<String>(imageRemoteUrl.value);
    }
    if (confidenceScore.present) {
      map['confidence_score'] = Variable<double>(confidenceScore.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('pestId: $pestId, ')
          ..write('cropType: $cropType, ')
          ..write('notes: $notes, ')
          ..write('imageLocalPath: $imageLocalPath, ')
          ..write('imageRemoteUrl: $imageRemoteUrl, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritePestsTable extends FavoritePests
    with TableInfo<$FavoritePestsTable, FavoritePest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pestIdMeta = const VerificationMeta('pestId');
  @override
  late final GeneratedColumn<String> pestId = GeneratedColumn<String>(
    'pest_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pestId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_pests';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritePest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pest_id')) {
      context.handle(
        _pestIdMeta,
        pestId.isAcceptableOrUnknown(data['pest_id']!, _pestIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pestIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pestId};
  @override
  FavoritePest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePest(
      pestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pest_id'],
      )!,
    );
  }

  @override
  $FavoritePestsTable createAlias(String alias) {
    return $FavoritePestsTable(attachedDatabase, alias);
  }
}

class FavoritePest extends DataClass implements Insertable<FavoritePest> {
  final String pestId;
  const FavoritePest({required this.pestId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pest_id'] = Variable<String>(pestId);
    return map;
  }

  FavoritePestsCompanion toCompanion(bool nullToAbsent) {
    return FavoritePestsCompanion(pestId: Value(pestId));
  }

  factory FavoritePest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePest(pestId: serializer.fromJson<String>(json['pestId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'pestId': serializer.toJson<String>(pestId)};
  }

  FavoritePest copyWith({String? pestId}) =>
      FavoritePest(pestId: pestId ?? this.pestId);
  FavoritePest copyWithCompanion(FavoritePestsCompanion data) {
    return FavoritePest(
      pestId: data.pestId.present ? data.pestId.value : this.pestId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePest(')
          ..write('pestId: $pestId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => pestId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePest && other.pestId == this.pestId);
}

class FavoritePestsCompanion extends UpdateCompanion<FavoritePest> {
  final Value<String> pestId;
  final Value<int> rowid;
  const FavoritePestsCompanion({
    this.pestId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritePestsCompanion.insert({
    required String pestId,
    this.rowid = const Value.absent(),
  }) : pestId = Value(pestId);
  static Insertable<FavoritePest> custom({
    Expression<String>? pestId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pestId != null) 'pest_id': pestId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritePestsCompanion copyWith({Value<String>? pestId, Value<int>? rowid}) {
    return FavoritePestsCompanion(
      pestId: pestId ?? this.pestId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pestId.present) {
      map['pest_id'] = Variable<String>(pestId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePestsCompanion(')
          ..write('pestId: $pestId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedPestsTable cachedPests = $CachedPestsTable(this);
  late final $ScansTable scans = $ScansTable(this);
  late final $FavoritePestsTable favoritePests = $FavoritePestsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedPests,
    scans,
    favoritePests,
  ];
}

typedef $$CachedPestsTableCreateCompanionBuilder =
    CachedPestsCompanion Function({
      required String id,
      required String nameFr,
      required String nameAr,
      required String nameEn,
      required String scientificName,
      Value<String> order,
      Value<String> family,
      required String dangerLevel,
      required String affectedCrops,
      Value<String> imageUrl,
      required String descriptionFr,
      required String descriptionAr,
      required String descriptionEn,
      required String symptomsFr,
      required String symptomsAr,
      required String symptomsEn,
      required String damageFr,
      required String damageAr,
      required String damageEn,
      required String preventionFr,
      required String preventionAr,
      required String preventionEn,
      required String biologicalTreatmentFr,
      required String biologicalTreatmentAr,
      required String biologicalTreatmentEn,
      required String chemicalTreatmentFr,
      required String chemicalTreatmentAr,
      required String chemicalTreatmentEn,
      Value<int> rowid,
    });
typedef $$CachedPestsTableUpdateCompanionBuilder =
    CachedPestsCompanion Function({
      Value<String> id,
      Value<String> nameFr,
      Value<String> nameAr,
      Value<String> nameEn,
      Value<String> scientificName,
      Value<String> order,
      Value<String> family,
      Value<String> dangerLevel,
      Value<String> affectedCrops,
      Value<String> imageUrl,
      Value<String> descriptionFr,
      Value<String> descriptionAr,
      Value<String> descriptionEn,
      Value<String> symptomsFr,
      Value<String> symptomsAr,
      Value<String> symptomsEn,
      Value<String> damageFr,
      Value<String> damageAr,
      Value<String> damageEn,
      Value<String> preventionFr,
      Value<String> preventionAr,
      Value<String> preventionEn,
      Value<String> biologicalTreatmentFr,
      Value<String> biologicalTreatmentAr,
      Value<String> biologicalTreatmentEn,
      Value<String> chemicalTreatmentFr,
      Value<String> chemicalTreatmentAr,
      Value<String> chemicalTreatmentEn,
      Value<int> rowid,
    });

final class $$CachedPestsTableReferences
    extends BaseReferences<_$AppDatabase, $CachedPestsTable, CachedPest> {
  $$CachedPestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScansTable, List<LocalScan>> _scansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scans,
    aliasName: $_aliasNameGenerator(db.cachedPests.id, db.scans.pestId),
  );

  $$ScansTableProcessedTableManager get scansRefs {
    final manager = $$ScansTableTableManager(
      $_db,
      $_db.scans,
    ).filter((f) => f.pestId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_scansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CachedPestsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedPestsTable> {
  $$CachedPestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get family => $composableBuilder(
    column: $table.family,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dangerLevel => $composableBuilder(
    column: $table.dangerLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get affectedCrops => $composableBuilder(
    column: $table.affectedCrops,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomsFr => $composableBuilder(
    column: $table.symptomsFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomsAr => $composableBuilder(
    column: $table.symptomsAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomsEn => $composableBuilder(
    column: $table.symptomsEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageFr => $composableBuilder(
    column: $table.damageFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageAr => $composableBuilder(
    column: $table.damageAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageEn => $composableBuilder(
    column: $table.damageEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preventionFr => $composableBuilder(
    column: $table.preventionFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preventionAr => $composableBuilder(
    column: $table.preventionAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preventionEn => $composableBuilder(
    column: $table.preventionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biologicalTreatmentFr => $composableBuilder(
    column: $table.biologicalTreatmentFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biologicalTreatmentAr => $composableBuilder(
    column: $table.biologicalTreatmentAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biologicalTreatmentEn => $composableBuilder(
    column: $table.biologicalTreatmentEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chemicalTreatmentFr => $composableBuilder(
    column: $table.chemicalTreatmentFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chemicalTreatmentAr => $composableBuilder(
    column: $table.chemicalTreatmentAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chemicalTreatmentEn => $composableBuilder(
    column: $table.chemicalTreatmentEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scansRefs(
    Expression<bool> Function($$ScansTableFilterComposer f) f,
  ) {
    final $$ScansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.pestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableFilterComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedPestsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedPestsTable> {
  $$CachedPestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get family => $composableBuilder(
    column: $table.family,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dangerLevel => $composableBuilder(
    column: $table.dangerLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get affectedCrops => $composableBuilder(
    column: $table.affectedCrops,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomsFr => $composableBuilder(
    column: $table.symptomsFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomsAr => $composableBuilder(
    column: $table.symptomsAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomsEn => $composableBuilder(
    column: $table.symptomsEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageFr => $composableBuilder(
    column: $table.damageFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageAr => $composableBuilder(
    column: $table.damageAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageEn => $composableBuilder(
    column: $table.damageEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preventionFr => $composableBuilder(
    column: $table.preventionFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preventionAr => $composableBuilder(
    column: $table.preventionAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preventionEn => $composableBuilder(
    column: $table.preventionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biologicalTreatmentFr => $composableBuilder(
    column: $table.biologicalTreatmentFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biologicalTreatmentAr => $composableBuilder(
    column: $table.biologicalTreatmentAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biologicalTreatmentEn => $composableBuilder(
    column: $table.biologicalTreatmentEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chemicalTreatmentFr => $composableBuilder(
    column: $table.chemicalTreatmentFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chemicalTreatmentAr => $composableBuilder(
    column: $table.chemicalTreatmentAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chemicalTreatmentEn => $composableBuilder(
    column: $table.chemicalTreatmentEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedPestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedPestsTable> {
  $$CachedPestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameFr =>
      $composableBuilder(column: $table.nameFr, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get family =>
      $composableBuilder(column: $table.family, builder: (column) => column);

  GeneratedColumn<String> get dangerLevel => $composableBuilder(
    column: $table.dangerLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get affectedCrops => $composableBuilder(
    column: $table.affectedCrops,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symptomsFr => $composableBuilder(
    column: $table.symptomsFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symptomsAr => $composableBuilder(
    column: $table.symptomsAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symptomsEn => $composableBuilder(
    column: $table.symptomsEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get damageFr =>
      $composableBuilder(column: $table.damageFr, builder: (column) => column);

  GeneratedColumn<String> get damageAr =>
      $composableBuilder(column: $table.damageAr, builder: (column) => column);

  GeneratedColumn<String> get damageEn =>
      $composableBuilder(column: $table.damageEn, builder: (column) => column);

  GeneratedColumn<String> get preventionFr => $composableBuilder(
    column: $table.preventionFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preventionAr => $composableBuilder(
    column: $table.preventionAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preventionEn => $composableBuilder(
    column: $table.preventionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biologicalTreatmentFr => $composableBuilder(
    column: $table.biologicalTreatmentFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biologicalTreatmentAr => $composableBuilder(
    column: $table.biologicalTreatmentAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biologicalTreatmentEn => $composableBuilder(
    column: $table.biologicalTreatmentEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chemicalTreatmentFr => $composableBuilder(
    column: $table.chemicalTreatmentFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chemicalTreatmentAr => $composableBuilder(
    column: $table.chemicalTreatmentAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chemicalTreatmentEn => $composableBuilder(
    column: $table.chemicalTreatmentEn,
    builder: (column) => column,
  );

  Expression<T> scansRefs<T extends Object>(
    Expression<T> Function($$ScansTableAnnotationComposer a) f,
  ) {
    final $$ScansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.pestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableAnnotationComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedPestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedPestsTable,
          CachedPest,
          $$CachedPestsTableFilterComposer,
          $$CachedPestsTableOrderingComposer,
          $$CachedPestsTableAnnotationComposer,
          $$CachedPestsTableCreateCompanionBuilder,
          $$CachedPestsTableUpdateCompanionBuilder,
          (CachedPest, $$CachedPestsTableReferences),
          CachedPest,
          PrefetchHooks Function({bool scansRefs})
        > {
  $$CachedPestsTableTableManager(_$AppDatabase db, $CachedPestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedPestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedPestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedPestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameFr = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> scientificName = const Value.absent(),
                Value<String> order = const Value.absent(),
                Value<String> family = const Value.absent(),
                Value<String> dangerLevel = const Value.absent(),
                Value<String> affectedCrops = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> descriptionFr = const Value.absent(),
                Value<String> descriptionAr = const Value.absent(),
                Value<String> descriptionEn = const Value.absent(),
                Value<String> symptomsFr = const Value.absent(),
                Value<String> symptomsAr = const Value.absent(),
                Value<String> symptomsEn = const Value.absent(),
                Value<String> damageFr = const Value.absent(),
                Value<String> damageAr = const Value.absent(),
                Value<String> damageEn = const Value.absent(),
                Value<String> preventionFr = const Value.absent(),
                Value<String> preventionAr = const Value.absent(),
                Value<String> preventionEn = const Value.absent(),
                Value<String> biologicalTreatmentFr = const Value.absent(),
                Value<String> biologicalTreatmentAr = const Value.absent(),
                Value<String> biologicalTreatmentEn = const Value.absent(),
                Value<String> chemicalTreatmentFr = const Value.absent(),
                Value<String> chemicalTreatmentAr = const Value.absent(),
                Value<String> chemicalTreatmentEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedPestsCompanion(
                id: id,
                nameFr: nameFr,
                nameAr: nameAr,
                nameEn: nameEn,
                scientificName: scientificName,
                order: order,
                family: family,
                dangerLevel: dangerLevel,
                affectedCrops: affectedCrops,
                imageUrl: imageUrl,
                descriptionFr: descriptionFr,
                descriptionAr: descriptionAr,
                descriptionEn: descriptionEn,
                symptomsFr: symptomsFr,
                symptomsAr: symptomsAr,
                symptomsEn: symptomsEn,
                damageFr: damageFr,
                damageAr: damageAr,
                damageEn: damageEn,
                preventionFr: preventionFr,
                preventionAr: preventionAr,
                preventionEn: preventionEn,
                biologicalTreatmentFr: biologicalTreatmentFr,
                biologicalTreatmentAr: biologicalTreatmentAr,
                biologicalTreatmentEn: biologicalTreatmentEn,
                chemicalTreatmentFr: chemicalTreatmentFr,
                chemicalTreatmentAr: chemicalTreatmentAr,
                chemicalTreatmentEn: chemicalTreatmentEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameFr,
                required String nameAr,
                required String nameEn,
                required String scientificName,
                Value<String> order = const Value.absent(),
                Value<String> family = const Value.absent(),
                required String dangerLevel,
                required String affectedCrops,
                Value<String> imageUrl = const Value.absent(),
                required String descriptionFr,
                required String descriptionAr,
                required String descriptionEn,
                required String symptomsFr,
                required String symptomsAr,
                required String symptomsEn,
                required String damageFr,
                required String damageAr,
                required String damageEn,
                required String preventionFr,
                required String preventionAr,
                required String preventionEn,
                required String biologicalTreatmentFr,
                required String biologicalTreatmentAr,
                required String biologicalTreatmentEn,
                required String chemicalTreatmentFr,
                required String chemicalTreatmentAr,
                required String chemicalTreatmentEn,
                Value<int> rowid = const Value.absent(),
              }) => CachedPestsCompanion.insert(
                id: id,
                nameFr: nameFr,
                nameAr: nameAr,
                nameEn: nameEn,
                scientificName: scientificName,
                order: order,
                family: family,
                dangerLevel: dangerLevel,
                affectedCrops: affectedCrops,
                imageUrl: imageUrl,
                descriptionFr: descriptionFr,
                descriptionAr: descriptionAr,
                descriptionEn: descriptionEn,
                symptomsFr: symptomsFr,
                symptomsAr: symptomsAr,
                symptomsEn: symptomsEn,
                damageFr: damageFr,
                damageAr: damageAr,
                damageEn: damageEn,
                preventionFr: preventionFr,
                preventionAr: preventionAr,
                preventionEn: preventionEn,
                biologicalTreatmentFr: biologicalTreatmentFr,
                biologicalTreatmentAr: biologicalTreatmentAr,
                biologicalTreatmentEn: biologicalTreatmentEn,
                chemicalTreatmentFr: chemicalTreatmentFr,
                chemicalTreatmentAr: chemicalTreatmentAr,
                chemicalTreatmentEn: chemicalTreatmentEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedPestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scansRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scansRefs) db.scans],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scansRefs)
                    await $_getPrefetchedData<
                      CachedPest,
                      $CachedPestsTable,
                      LocalScan
                    >(
                      currentTable: table,
                      referencedTable: $$CachedPestsTableReferences
                          ._scansRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CachedPestsTableReferences(db, table, p0).scansRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.pestId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CachedPestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedPestsTable,
      CachedPest,
      $$CachedPestsTableFilterComposer,
      $$CachedPestsTableOrderingComposer,
      $$CachedPestsTableAnnotationComposer,
      $$CachedPestsTableCreateCompanionBuilder,
      $$CachedPestsTableUpdateCompanionBuilder,
      (CachedPest, $$CachedPestsTableReferences),
      CachedPest,
      PrefetchHooks Function({bool scansRefs})
    >;
typedef $$ScansTableCreateCompanionBuilder =
    ScansCompanion Function({
      required String id,
      Value<String?> userId,
      Value<String?> pestId,
      required String cropType,
      Value<String?> notes,
      required String imageLocalPath,
      Value<String?> imageRemoteUrl,
      required double confidenceScore,
      required DateTime createdAt,
      required String syncStatus,
      Value<int> rowid,
    });
typedef $$ScansTableUpdateCompanionBuilder =
    ScansCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<String?> pestId,
      Value<String> cropType,
      Value<String?> notes,
      Value<String> imageLocalPath,
      Value<String?> imageRemoteUrl,
      Value<double> confidenceScore,
      Value<DateTime> createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$ScansTableReferences
    extends BaseReferences<_$AppDatabase, $ScansTable, LocalScan> {
  $$ScansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CachedPestsTable _pestIdTable(_$AppDatabase db) => db.cachedPests
      .createAlias($_aliasNameGenerator(db.scans.pestId, db.cachedPests.id));

  $$CachedPestsTableProcessedTableManager? get pestId {
    final $_column = $_itemColumn<String>('pest_id');
    if ($_column == null) return null;
    final manager = $$CachedPestsTableTableManager(
      $_db,
      $_db.cachedPests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pestIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScansTableFilterComposer extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cropType => $composableBuilder(
    column: $table.cropType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageLocalPath => $composableBuilder(
    column: $table.imageLocalPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageRemoteUrl => $composableBuilder(
    column: $table.imageRemoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$CachedPestsTableFilterComposer get pestId {
    final $$CachedPestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pestId,
      referencedTable: $db.cachedPests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedPestsTableFilterComposer(
            $db: $db,
            $table: $db.cachedPests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableOrderingComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cropType => $composableBuilder(
    column: $table.cropType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageLocalPath => $composableBuilder(
    column: $table.imageLocalPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageRemoteUrl => $composableBuilder(
    column: $table.imageRemoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$CachedPestsTableOrderingComposer get pestId {
    final $$CachedPestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pestId,
      referencedTable: $db.cachedPests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedPestsTableOrderingComposer(
            $db: $db,
            $table: $db.cachedPests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get cropType =>
      $composableBuilder(column: $table.cropType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imageLocalPath => $composableBuilder(
    column: $table.imageLocalPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageRemoteUrl => $composableBuilder(
    column: $table.imageRemoteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$CachedPestsTableAnnotationComposer get pestId {
    final $$CachedPestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pestId,
      referencedTable: $db.cachedPests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedPestsTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedPests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScansTable,
          LocalScan,
          $$ScansTableFilterComposer,
          $$ScansTableOrderingComposer,
          $$ScansTableAnnotationComposer,
          $$ScansTableCreateCompanionBuilder,
          $$ScansTableUpdateCompanionBuilder,
          (LocalScan, $$ScansTableReferences),
          LocalScan,
          PrefetchHooks Function({bool pestId})
        > {
  $$ScansTableTableManager(_$AppDatabase db, $ScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> pestId = const Value.absent(),
                Value<String> cropType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> imageLocalPath = const Value.absent(),
                Value<String?> imageRemoteUrl = const Value.absent(),
                Value<double> confidenceScore = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScansCompanion(
                id: id,
                userId: userId,
                pestId: pestId,
                cropType: cropType,
                notes: notes,
                imageLocalPath: imageLocalPath,
                imageRemoteUrl: imageRemoteUrl,
                confidenceScore: confidenceScore,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                Value<String?> pestId = const Value.absent(),
                required String cropType,
                Value<String?> notes = const Value.absent(),
                required String imageLocalPath,
                Value<String?> imageRemoteUrl = const Value.absent(),
                required double confidenceScore,
                required DateTime createdAt,
                required String syncStatus,
                Value<int> rowid = const Value.absent(),
              }) => ScansCompanion.insert(
                id: id,
                userId: userId,
                pestId: pestId,
                cropType: cropType,
                notes: notes,
                imageLocalPath: imageLocalPath,
                imageRemoteUrl: imageRemoteUrl,
                confidenceScore: confidenceScore,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ScansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({pestId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pestId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pestId,
                                referencedTable: $$ScansTableReferences
                                    ._pestIdTable(db),
                                referencedColumn: $$ScansTableReferences
                                    ._pestIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScansTable,
      LocalScan,
      $$ScansTableFilterComposer,
      $$ScansTableOrderingComposer,
      $$ScansTableAnnotationComposer,
      $$ScansTableCreateCompanionBuilder,
      $$ScansTableUpdateCompanionBuilder,
      (LocalScan, $$ScansTableReferences),
      LocalScan,
      PrefetchHooks Function({bool pestId})
    >;
typedef $$FavoritePestsTableCreateCompanionBuilder =
    FavoritePestsCompanion Function({required String pestId, Value<int> rowid});
typedef $$FavoritePestsTableUpdateCompanionBuilder =
    FavoritePestsCompanion Function({Value<String> pestId, Value<int> rowid});

class $$FavoritePestsTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritePestsTable> {
  $$FavoritePestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get pestId => $composableBuilder(
    column: $table.pestId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritePestsTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritePestsTable> {
  $$FavoritePestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get pestId => $composableBuilder(
    column: $table.pestId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritePestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritePestsTable> {
  $$FavoritePestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get pestId =>
      $composableBuilder(column: $table.pestId, builder: (column) => column);
}

class $$FavoritePestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritePestsTable,
          FavoritePest,
          $$FavoritePestsTableFilterComposer,
          $$FavoritePestsTableOrderingComposer,
          $$FavoritePestsTableAnnotationComposer,
          $$FavoritePestsTableCreateCompanionBuilder,
          $$FavoritePestsTableUpdateCompanionBuilder,
          (
            FavoritePest,
            BaseReferences<_$AppDatabase, $FavoritePestsTable, FavoritePest>,
          ),
          FavoritePest,
          PrefetchHooks Function()
        > {
  $$FavoritePestsTableTableManager(_$AppDatabase db, $FavoritePestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritePestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritePestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritePestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> pestId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritePestsCompanion(pestId: pestId, rowid: rowid),
          createCompanionCallback:
              ({
                required String pestId,
                Value<int> rowid = const Value.absent(),
              }) => FavoritePestsCompanion.insert(pestId: pestId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritePestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritePestsTable,
      FavoritePest,
      $$FavoritePestsTableFilterComposer,
      $$FavoritePestsTableOrderingComposer,
      $$FavoritePestsTableAnnotationComposer,
      $$FavoritePestsTableCreateCompanionBuilder,
      $$FavoritePestsTableUpdateCompanionBuilder,
      (
        FavoritePest,
        BaseReferences<_$AppDatabase, $FavoritePestsTable, FavoritePest>,
      ),
      FavoritePest,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedPestsTableTableManager get cachedPests =>
      $$CachedPestsTableTableManager(_db, _db.cachedPests);
  $$ScansTableTableManager get scans =>
      $$ScansTableTableManager(_db, _db.scans);
  $$FavoritePestsTableTableManager get favoritePests =>
      $$FavoritePestsTableTableManager(_db, _db.favoritePests);
}
