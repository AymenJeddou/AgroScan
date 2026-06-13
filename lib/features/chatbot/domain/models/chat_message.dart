enum MessageRole { user, assistant }

class ChatMessage {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessage.user(String content) => ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: MessageRole.user,
        content: content,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.assistant(String content) => ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: MessageRole.assistant,
        content: content,
        timestamp: DateTime.now(),
      );

  bool get isUser => role == MessageRole.user;
}
