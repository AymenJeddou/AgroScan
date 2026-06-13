import 'dart:io';
import 'dart:math';
import '../../../library/domain/repositories/library_repository.dart';
import '../../domain/models/inference_result.dart';
import '../../domain/repositories/ai_inference_repository.dart';

class MockInferenceRepository implements AIInferenceRepository {
  final LibraryRepository _libraryRepository;
  final Random _random = Random();

  MockInferenceRepository(this._libraryRepository);

  @override
  Future<InferenceResult> analyzeImage(File image, String cropType) async {
    // 1. Simulate AI processing time (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // 2. Decide if the plant is healthy (20% chance)
    final isHealthy = _random.nextDouble() < 0.2;
    if (isHealthy) {
      return InferenceResult.healthy(cropType);
    }

    // 3. Fetch pests affecting this crop from the library
    final pests = await _libraryRepository.getPestsByCrop(cropType);
    
    if (pests.isEmpty) {
      // Fallback to healthy if no pests are available in cache
      return InferenceResult.healthy(cropType);
    }

    // 4. Select a random pest
    final pest = pests[_random.nextInt(pests.length)];
    final confidence = 0.80 + (_random.nextDouble() * 0.18); // 80% to 98%

    return InferenceResult(
      pestId: pest.id,
      pestName: pest.nameFr, // Store default name, details screen will display localized text using ID
      confidenceScore: confidence,
      cropType: cropType,
      isHealthy: false,
    );
  }
}
