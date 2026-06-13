import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/pest.dart';

extension CachedPestMapper on CachedPest {
  Pest toDomain() {
    return Pest(
      id: id,
      nameFr: nameFr,
      nameAr: nameAr,
      nameEn: nameEn,
      scientificName: scientificName,
      order: order,
      family: family,
      dangerLevel: DangerLevel.fromString(dangerLevel),
      affectedCrops: List<String>.from(jsonDecode(affectedCrops) as List),
      imageUrl: imageUrl,
      descriptionFr: descriptionFr,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      symptomsFr: List<String>.from(jsonDecode(symptomsFr) as List),
      symptomsAr: List<String>.from(jsonDecode(symptomsAr) as List),
      symptomsEn: List<String>.from(jsonDecode(symptomsEn) as List),
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
      cultures: const [],
      milieu: 'plein_champ',
      isPolyphage: false,
      isQuarantaine: false,
    );
  }
}

extension PestMapper on Pest {
  CachedPestsCompanion toCompanion() {
    return CachedPestsCompanion(
      id: Value(id),
      nameFr: Value(nameFr),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      scientificName: Value(scientificName),
      order: Value(order),
      family: Value(family),
      dangerLevel: Value(dangerLevel.toMapString()),
      affectedCrops: Value(jsonEncode(affectedCrops)),
      imageUrl: Value(imageUrl),
      descriptionFr: Value(descriptionFr),
      descriptionAr: Value(descriptionAr),
      descriptionEn: Value(descriptionEn),
      symptomsFr: Value(jsonEncode(symptomsFr)),
      symptomsAr: Value(jsonEncode(symptomsAr)),
      symptomsEn: Value(jsonEncode(symptomsEn)),
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
}
