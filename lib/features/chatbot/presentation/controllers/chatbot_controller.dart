import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/chat_message.dart';
import '../../data/services/chatbot_service.dart';

// Provider for the chatbot service instance (kept alive for history)
final chatbotServiceProvider = Provider<ChatbotService>((ref) {
  final service = ChatbotService();
  ref.onDispose(() => service.reset());
  return service;
});

// State
class ChatbotState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? errorMessage;

  const ChatbotState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Controller
class ChatbotController extends StateNotifier<ChatbotState> {
  final ChatbotService _service;

  ChatbotController(this._service) : super(const ChatbotState()) {
    _sendWelcome();
  }

  void _sendWelcome() {
    final welcome = ChatMessage.assistant(
      '👋 Bonjour ! Je suis **AgriBot**, votre expert en ravageurs agricoles.\n\n'
      'Je peux vous aider avec :\n'
      '🔍 Identification des ravageurs\n'
      '💊 Traitements et remèdes\n'
      '🌱 Prévention et bonnes pratiques\n'
      '🐛 Familles et cycles de vie\n\n'
      'Posez votre question !',
    );
    state = state.copyWith(messages: [welcome]);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.isLoading) return;

    final userMsg = ChatMessage.user(text.trim());
    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isLoading: true,
      errorMessage: null,
    );

    try {
      final reply = await _service.sendMessage(text.trim());
      final assistantMsg = ChatMessage.assistant(reply);
      state = state.copyWith(
        messages: [...state.messages, assistantMsg],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur de connexion. Vérifiez votre réseau.',
      );
    }
  }

  Future<void> startWithScanContext({
    required String pestName,
    required String cropType,
    required double confidence,
  }) async {
    // Reset conversation for new scan context
    _service.reset();

    final contextMsg = ChatMessage.user(
      '📷 Scan détecté : **$pestName** sur $cropType (${(confidence * 100).toStringAsFixed(0)}% de confiance)\n\nDonne-moi plus d\'informations.',
    );

    state = state.copyWith(
      messages: [...state.messages, contextMsg],
      isLoading: true,
      errorMessage: null,
    );

    try {
      final reply = await _service.startWithScanContext(
        pestName: pestName,
        cropType: cropType,
        confidence: confidence,
      );
      final assistantMsg = ChatMessage.assistant(reply);
      state = state.copyWith(
        messages: [...state.messages, assistantMsg],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur de connexion. Vérifiez votre réseau.',
      );
    }
  }

  void clearChat() {
    _service.reset();
    state = const ChatbotState();
    _sendWelcome();
  }
}

final chatbotControllerProvider =
    StateNotifierProvider<ChatbotController, ChatbotState>((ref) {
  final service = ref.watch(chatbotServiceProvider);
  return ChatbotController(service);
});
