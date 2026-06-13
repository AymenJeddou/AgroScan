class PestGuess {
  final String? pestId;
  final String pestName;
  final double confidenceScore;

  const PestGuess({
    this.pestId,
    required this.pestName,
    required this.confidenceScore,
  });
}

class InferenceResult {
  final String? pestId;
  final String? pestName;
  final double confidenceScore;
  final String cropType;
  final bool isHealthy;
  final bool isRelevantImage; // false when image is not a plant/crop at all
  final String? summary;      // brief AI-generated description of the finding
  final List<PestGuess> topGuesses;

  const InferenceResult({
    this.pestId,
    this.pestName,
    required this.confidenceScore,
    required this.cropType,
    required this.isHealthy,
    this.isRelevantImage = true,
    this.summary,
    this.topGuesses = const [],
  });

  factory InferenceResult.healthy(String cropType, {String? summary}) {
    return InferenceResult(
      confidenceScore: 0.95,
      cropType: cropType,
      isHealthy: true,
      isRelevantImage: true,
      summary: summary,
      topGuesses: const [
        PestGuess(pestName: 'Sain / Healthy', confidenceScore: 0.95),
      ],
    );
  }

  factory InferenceResult.notRelevant(String cropType) {
    return InferenceResult(
      confidenceScore: 0.0,
      cropType: cropType,
      isHealthy: false,
      isRelevantImage: false,
      summary: null,
      topGuesses: const [],
    );
  }
}
