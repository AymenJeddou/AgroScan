enum DangerLevel {
  low,
  medium,
  high;

  static DangerLevel fromString(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return DangerLevel.low;
      case 'high':
        return DangerLevel.high;
      case 'medium':
      default:
        return DangerLevel.medium;
    }
  }

  String toMapString() => name;
}

class Pest {
  final String id;
  final String nameFr;
  final String nameAr;
  final String nameEn;
  final String scientificName;
  final String order;
  final String family;
  final DangerLevel dangerLevel;
  final List<String> affectedCrops;
  final String imageUrl;
  final List<String> localImages;
  final String descriptionFr;
  final String descriptionAr;
  final String descriptionEn;
  final List<String> symptomsFr;
  final List<String> symptomsAr;
  final List<String> symptomsEn;
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
  final List<String> cultures;
  final String milieu;
  final bool isPolyphage;
  final bool isQuarantaine;
  final String lifecycleFr;
  final String lifecycleEn;
  final String lifecycleAr;
  final String mechanicalControlFr;
  final String mechanicalControlEn;
  final String mechanicalControlAr;

  const Pest({
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
    this.localImages = const [],
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
    required this.cultures,
    required this.milieu,
    required this.isPolyphage,
    required this.isQuarantaine,
    this.lifecycleFr = '',
    this.lifecycleEn = '',
    this.lifecycleAr = '',
    this.mechanicalControlFr = '',
    this.mechanicalControlEn = '',
    this.mechanicalControlAr = '',
  });

  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      id: json['id'] as String,
      nameFr: json['name_fr'] as String,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      scientificName: json['scientific_name'] as String,
      order: json['order'] as String? ?? '',
      family: json['family'] as String? ?? '',
      dangerLevel: DangerLevel.fromString(json['danger_level'] as String),
      affectedCrops: List<String>.from(json['affected_crops'] as List),
      imageUrl: json['image_url'] as String? ?? '',
      localImages: List<String>.from((json['local_images'] as List?) ?? const []),
      descriptionFr: json['description_fr'] as String,
      descriptionAr: json['description_ar'] as String,
      descriptionEn: json['description_en'] as String,
      symptomsFr: List<String>.from(json['symptoms_fr'] as List),
      symptomsAr: List<String>.from(json['symptoms_ar'] as List),
      symptomsEn: List<String>.from(json['symptoms_en'] as List),
      damageFr: json['damage_fr'] as String,
      damageAr: json['damage_ar'] as String,
      damageEn: json['damage_en'] as String,
      preventionFr: json['prevention_fr'] as String,
      preventionAr: json['prevention_ar'] as String,
      preventionEn: json['prevention_en'] as String,
      biologicalTreatmentFr: json['biological_treatment_fr'] as String,
      biologicalTreatmentAr: json['biological_treatment_ar'] as String,
      biologicalTreatmentEn: json['biological_treatment_en'] as String,
      chemicalTreatmentFr: json['chemical_treatment_fr'] as String,
      chemicalTreatmentAr: json['chemical_treatment_ar'] as String,
      chemicalTreatmentEn: json['chemical_treatment_en'] as String,
      cultures: List<String>.from((json['cultures'] as List?) ?? const []),
      milieu: json['milieu'] as String? ?? 'plein_champ',
      isPolyphage: json['is_polyphage'] as bool? ?? false,
      isQuarantaine: json['is_quarantaine'] as bool? ?? false,
      lifecycleFr: json['lifecycle_fr'] as String? ?? '',
      lifecycleEn: json['lifecycle_en'] as String? ?? '',
      lifecycleAr: json['lifecycle_ar'] as String? ?? '',
      mechanicalControlFr: json['mechanical_control_fr'] as String? ?? '',
      mechanicalControlEn: json['mechanical_control_en'] as String? ?? '',
      mechanicalControlAr: json['mechanical_control_ar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_fr': nameFr,
      'name_ar': nameAr,
      'name_en': nameEn,
      'scientific_name': scientificName,
      'order': order,
      'family': family,
      'danger_level': dangerLevel.toMapString(),
      'affected_crops': affectedCrops,
      'image_url': imageUrl,
      'local_images': localImages,
      'description_fr': descriptionFr,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'symptoms_fr': symptomsFr,
      'symptoms_ar': symptomsAr,
      'symptoms_en': symptomsEn,
      'damage_fr': damageFr,
      'damage_ar': damageAr,
      'damage_en': damageEn,
      'prevention_fr': preventionFr,
      'prevention_ar': preventionAr,
      'prevention_en': preventionEn,
      'biological_treatment_fr': biologicalTreatmentFr,
      'biological_treatment_ar': biologicalTreatmentAr,
      'biological_treatment_en': biologicalTreatmentEn,
      'chemical_treatment_fr': chemicalTreatmentFr,
      'chemical_treatment_ar': chemicalTreatmentAr,
      'chemical_treatment_en': chemicalTreatmentEn,
      'cultures': cultures,
      'milieu': milieu,
      'is_polyphage': isPolyphage,
      'is_quarantaine': isQuarantaine,
      'lifecycle_fr': lifecycleFr,
      'lifecycle_en': lifecycleEn,
      'lifecycle_ar': lifecycleAr,
      'mechanical_control_fr': mechanicalControlFr,
      'mechanical_control_en': mechanicalControlEn,
      'mechanical_control_ar': mechanicalControlAr,
    };
  }

  String getName(String locale) {
    if (locale.startsWith('ar')) return nameAr;
    if (locale.startsWith('en')) return nameEn;
    return nameFr;
  }

  String getDescription(String locale) {
    if (locale.startsWith('ar')) return descriptionAr;
    if (locale.startsWith('en')) return descriptionEn;
    return descriptionFr;
  }

  List<String> getSymptoms(String locale) {
    if (locale.startsWith('ar')) return symptomsAr;
    if (locale.startsWith('en')) return symptomsEn;
    return symptomsFr;
  }

  String getDamage(String locale) {
    if (locale.startsWith('ar')) return damageAr;
    if (locale.startsWith('en')) return damageEn;
    return damageFr;
  }

  String getPrevention(String locale) {
    if (locale.startsWith('ar')) return preventionAr;
    if (locale.startsWith('en')) return preventionEn;
    return preventionFr;
  }

  String getBiologicalTreatment(String locale) {
    if (locale.startsWith('ar')) return biologicalTreatmentAr;
    if (locale.startsWith('en')) return biologicalTreatmentEn;
    return biologicalTreatmentFr;
  }

  String getChemicalTreatment(String locale) {
    if (locale.startsWith('ar')) return chemicalTreatmentAr;
    if (locale.startsWith('en')) return chemicalTreatmentEn;
    return chemicalTreatmentFr;
  }

  // Lifecycle and mechanical control fall back to French when a translation
  // for the active locale has not been provided.
  String getLifecycle(String locale) {
    if (locale.startsWith('ar')) return lifecycleAr.isNotEmpty ? lifecycleAr : lifecycleFr;
    if (locale.startsWith('en')) return lifecycleEn.isNotEmpty ? lifecycleEn : lifecycleFr;
    return lifecycleFr;
  }

  String getMechanicalControl(String locale) {
    if (locale.startsWith('ar')) {
      return mechanicalControlAr.isNotEmpty ? mechanicalControlAr : mechanicalControlFr;
    }
    if (locale.startsWith('en')) {
      return mechanicalControlEn.isNotEmpty ? mechanicalControlEn : mechanicalControlFr;
    }
    return mechanicalControlFr;
  }
}
