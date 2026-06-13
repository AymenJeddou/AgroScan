import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/inference_result.dart';
import '../../domain/repositories/ai_inference_repository.dart';
import '../../../history/domain/models/scan.dart';
import '../../../history/domain/repositories/scan_repository.dart';
import '../../../../core/providers.dart';

enum ScanUIStatus { idle, capturing, analyzing, completed, error }

class ScanState {
  final File? image;
  final String cropType; // 'tomato' or 'pepper'
  final ScanUIStatus status;
  final InferenceResult? result;
  final String? errorMessage;

  const ScanState({
    this.image,
    required this.cropType,
    required this.status,
    this.result,
    this.errorMessage,
  });

  ScanState copyWith({
    File? image,
    String? cropType,
    ScanUIStatus? status,
    InferenceResult? result,
    String? errorMessage,
    bool clearImage = false,
    bool clearResult = false,
  }) {
    return ScanState(
      image: clearImage ? null : (image ?? this.image),
      cropType: cropType ?? this.cropType,
      status: status ?? this.status,
      result: clearResult ? null : (result ?? this.result),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ScanController extends StateNotifier<ScanState> {
  final AIInferenceRepository _inferenceRepository;
  final ScanRepository _scanRepository;
  final ImagePicker _picker = ImagePicker();

  ScanController(this._inferenceRepository, this._scanRepository)
      : super(const ScanState(
          cropType: '',
          status: ScanUIStatus.idle,
        ));

  void setCropType(String cropType) {
    state = state.copyWith(cropType: cropType.toLowerCase());
  }

  void reset() {
    state = state.copyWith(
      status: ScanUIStatus.idle,
      clearImage: true,
      clearResult: true,
      errorMessage: null,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      state = state.copyWith(status: ScanUIStatus.capturing);
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile == null) {
        state = state.copyWith(status: ScanUIStatus.idle);
        return;
      }

      final file = File(pickedFile.path);
      state = state.copyWith(
        image: file,
        status: ScanUIStatus.analyzing,
      );

      // Start classification automatically
      await _runInference(file);
    } catch (e) {
      state = state.copyWith(
        status: ScanUIStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _runInference(File file) async {
    try {
      final inferenceResult = await _inferenceRepository.analyzeImage(
        file,
        state.cropType,
      );

      // Only persist scans of relevant images (an actual plant/crop/pest).
      // Irrelevant photos (chair, screen, random objects) must never land in
      // history — they would otherwise be counted as "healthy plant".
      if (inferenceResult.isRelevantImage) {
        final scanRecord = Scan(
          id: const Uuid().v4(),
          pestId: inferenceResult.pestId,
          cropType: state.cropType,
          notes: inferenceResult.isHealthy ? null : inferenceResult.pestName,
          imageLocalPath: file.path,
          confidenceScore: inferenceResult.confidenceScore,
          createdAt: DateTime.now(),
          syncStatus: SyncStatus.pendingInsert,
        );

        // Save locally (triggers background Supabase sync inside repo)
        await _scanRepository.saveScan(scanRecord);
      }

      state = state.copyWith(
        status: ScanUIStatus.completed,
        result: inferenceResult,
      );
    } catch (e) {
      state = state.copyWith(
        status: ScanUIStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

// Scan Controller Provider
final scanControllerProvider =
    StateNotifierProvider<ScanController, ScanState>((ref) {
  final inferenceRepo = ref.watch(aiInferenceRepositoryProvider);
  final scanRepo = ref.watch(scanRepositoryProvider);
  return ScanController(inferenceRepo, scanRepo);
});
