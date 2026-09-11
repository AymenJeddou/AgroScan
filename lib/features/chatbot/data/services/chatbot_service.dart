import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/gemini_config.dart';

class ChatbotService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  static const String _systemContext = '''
Tu es AgriBot, un expert en ravageurs agricoles et maladies des plantes, spécialisé dans les cultures maraîchères (tomates, poivrons, pommes de terre, etc.).
Tu connais en profondeur tous les ravageurs suivants (et bien d'autres) :

- Puceron vert du pêcher (Myzus persicae) — pest_01
- Aleurode des serres (Trialeurodes vaporariorum) — pest_02
- Mineuse de la tomate (Tuta absoluta) — pest_03
- Noctuelle de la tomate / Helicoverpa armigera — pest_04
- Tétranyque tisserand (Tetranychus urticae) — pest_05
- Thrips des serres (Heliothrips haemorrhoidalis) — pest_06
- Doryphore de la pomme de terre (Leptinotarsa decemlineata) — pest_07
- Punaise potagère verte (Nezara viridula) — pest_08
- Altise de la pomme de terre (Epitrix cucumeris) — pest_09
- Ver gris / Noctuelle terricole (Agrotis ipsilon) — pest_10
- Mouche mineuse des feuilles (Liriomyza bryoniae) — pest_11
- Psylle de la tomate (Bactericera cockerelli) — pest_12
- Pyrale du maïs (Ostrinia nubilalis) — pest_13
- Charançon du poivron (Anthonomus eugenii) — pest_14

Et aussi tous les autres ravageurs courants non listés ici.

Tu peux répondre aux questions sur :
- Identification des ravageurs (symptômes, description visuelle)
- Traitements biologiques, chimiques et intégrés (IPM)
- Prévention et bonnes pratiques agricoles
- Classification taxonomique (famille, ordre, genre, espèce)
- Cycle de vie et comportement des ravageurs
- Cultures affectées et périodes à risque

Réponds toujours en français par défaut (sauf si l'utilisateur parle en anglais ou arabe).
Sois concis, professionnel et utile. Utilise des emojis quand cela aide la lisibilité. Ne réponds qu'aux questions sur les ravageurs, maladies des plantes et agriculture.
''';

  final List<Map<String, dynamic>> _history = [];
  static const _maxHistoryTurns = 20;

  Future<String> sendMessage(String userMessage) async {
    _history.add({
      'role': 'user',
      'parts': [{'text': userMessage}],
    });

    try {
      final url = Uri.parse(_baseUrl);

      // Trim to the most recent turns to prevent unbounded context growth.
      final trimmed = _history.length > _maxHistoryTurns
          ? _history.sublist(_history.length - _maxHistoryTurns)
          : List<Map<String, dynamic>>.from(_history);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': GeminiConfig.apiKey,
        },
        body: jsonEncode({
          'system_instruction': {
            'parts': [{'text': _systemContext}],
          },
          'contents': trimmed,
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 1024,
          },
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw Exception('Chatbot API error ${response.statusCode}: ${response.body}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final candidate = (data['candidates'] as List?)?.first as Map<String, dynamic>?;
      final content = candidate?['content'] as Map<String, dynamic>?;
      final reply = ((content?['parts'] as List?)?.first as Map<String, dynamic>?)?['text'] as String?;
      if (reply == null) {
        throw Exception(
          'Chatbot returned no content (finishReason: ${candidate?['finishReason']})',
        );
      }
      _history.add({
        'role': 'model',
        'parts': [{'text': reply}],
      });
      return reply;
    } catch (e) {
      // Roll back the user turn so a retry doesn't produce consecutive user messages.
      _history.removeLast();
      rethrow;
    }
  }

  /// Start a conversation with scan context pre-loaded
  Future<String> startWithScanContext({
    required String pestName,
    required String cropType,
    required double confidence,
  }) async {
    final contextMessage =
        'J\'ai analysé une image de $cropType et j\'ai détecté un ravageur possible : "$pestName" avec une confiance de ${(confidence * 100).toStringAsFixed(0)}%. '
        'Donne-moi un résumé rapide de ce ravageur, les symptômes clés à confirmer et les premières actions à prendre.';

    return sendMessage(contextMessage);
  }

  void reset() {
    _history.clear();
  }
}
