import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agroscan/features/library/domain/repositories/library_repository.dart';
import 'package:agroscan/features/library/domain/models/pest.dart';
import 'package:agroscan/features/scanning/data/repositories/mock_inference_repository.dart';

class MockLibraryRepository extends Mock implements LibraryRepository {}

void main() {
  late MockLibraryRepository mockLibraryRepository;
  late MockInferenceRepository mockInferenceRepository;

  setUp(() {
    mockLibraryRepository = MockLibraryRepository();
    mockInferenceRepository = MockInferenceRepository(mockLibraryRepository);
  });

  group('MockInferenceRepository Tests', () {
    final mockPests = [
      const Pest(
        id: 'pest_01',
        nameFr: 'Puceron',
        nameAr: 'من',
        nameEn: 'Aphid',
        scientificName: 'Myzus persicae',
        order: 'Hemiptera',
        family: 'Aphididae',
        dangerLevel: DangerLevel.medium,
        affectedCrops: ['tomato', 'pepper'],
        imageUrl: '',
        descriptionFr: 'Desc',
        descriptionAr: 'وصف',
        descriptionEn: 'Desc',
        symptomsFr: ['sym'],
        symptomsAr: ['عرض'],
        symptomsEn: ['sym'],
        damageFr: 'dmg',
        damageAr: 'ضرر',
        damageEn: 'dmg',
        preventionFr: 'prev',
        preventionAr: 'وقاية',
        preventionEn: 'prev',
        biologicalTreatmentFr: 'bio',
        biologicalTreatmentAr: 'حيوي',
        biologicalTreatmentEn: 'bio',
        chemicalTreatmentFr: 'chem',
        chemicalTreatmentAr: 'كيميائي',
        chemicalTreatmentEn: 'chem',
        cultures: [],
        milieu: 'plein_champ',
        isPolyphage: false,
        isQuarantaine: false,
      )
    ];

    test('analyzeImage returns valid result (either healthy or selected pest)', () async {
      // Arrange
      when(() => mockLibraryRepository.getPestsByCrop('tomato'))
          .thenAnswer((_) async => mockPests);

      final dummyFile = File('dummy_path/image.png');

      // Act
      final result = await mockInferenceRepository.analyzeImage(dummyFile, 'tomato');

      // Assert
      expect(result.cropType, equals('tomato'));
      expect(result.confidenceScore, isNotNull); // we'll check value bounds
      expect(result.confidenceScore, greaterThanOrEqualTo(0.80));
      expect(result.confidenceScore, lessThanOrEqualTo(0.98));
      
      if (result.isHealthy) {
        expect(result.pestId, isNull);
        expect(result.pestName, isNull);
      } else {
        expect(result.pestId, equals('pest_01'));
        expect(result.pestName, equals('Puceron'));
      }
    });

    test('analyzeImage returns healthy fallback when library is empty', () async {
      // Arrange
      when(() => mockLibraryRepository.getPestsByCrop('tomato'))
          .thenAnswer((_) async => <Pest>[]);

      final dummyFile = File('dummy_path/image.png');

      // Act
      final result = await mockInferenceRepository.analyzeImage(dummyFile, 'tomato');

      // Assert
      expect(result.isHealthy, isTrue);
      expect(result.pestId, isNull);
      expect(result.confidenceScore, equals(0.95)); // Default healthy confidence score
    });
  });
}
