import 'dart:io';
import '../models/inference_result.dart';

abstract class AIInferenceRepository {
  /// Analyzes the provided crop image and returns the inference result.
  /// [cropType] is used to filter matching pests (e.g. 'tomato' or 'pepper').
  Future<InferenceResult> analyzeImage(File image, String cropType);
}
