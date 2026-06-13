import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_theme.dart';
import '../../domain/models/chat_message.dart';
import '../controllers/chatbot_controller.dart';

class ChatbotScreen extends ConsumerStatefulWidget {
  const ChatbotScreen({super.key});

  @override
  ConsumerState<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends ConsumerState<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  static const List<String> _quickPrompts = [
    '🐛 Symptômes du puceron vert',
    '💊 Traitement contre les aleurodes',
    '🌿 Prévention naturelle',
    '🔬 Tétranyque tisserand',
    '🍅 Ravageurs de la tomate',
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _send() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    ref.read(chatbotControllerProvider.notifier).sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(chatbotControllerProvider);

    ref.listen(chatbotControllerProvider, (prev, next) {
      if (prev?.messages.length != next.messages.length || !next.isLoading) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AgriBot',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Expert en ravageurs agricoles',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.mutedTextColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.primaryColor),
            tooltip: 'Nouvelle conversation',
            onPressed: () {
              ref.read(chatbotControllerProvider.notifier).clearChat();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -60, right: -40,
            child: Container(
              width: 160, height: 160,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 120, left: -30,
            child: Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              // Messages list
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  itemCount: state.messages.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.messages.length && state.isLoading) {
                      return _buildTypingIndicator(theme);
                    }
                    final msg = state.messages[index];
                    return _buildMessageBubble(msg, theme);
                  },
                ),
              ),

              // Error banner
              if (state.errorMessage != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.dangerHigh.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.dangerHigh.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.wifi_off, size: 16, color: AppTheme.dangerHigh),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: AppTheme.dangerHigh, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              // Quick prompts (only when few messages)
              if (state.messages.length <= 1 && !state.isLoading)
                _buildQuickPrompts(theme),

              // Input area
              _buildInputArea(theme, state.isLoading),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, ThemeData theme) {
    final isUser = msg.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.accentColor],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppTheme.primaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isUser ? AppTheme.primaryColor : Colors.black)
                        .withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _buildMessageText(msg.content, isUser, theme),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: AppTheme.primaryColor, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageText(String content, bool isUser, ThemeData theme) {
    // Simple bold markdown: **text** -> bold
    final spans = <TextSpan>[];
    final parts = content.split('**');
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: TextStyle(
          color: isUser ? Colors.white : AppTheme.textColor,
          fontWeight: i.isOdd ? FontWeight.w700 : FontWeight.normal,
          fontSize: 14.5,
          height: 1.5,
        ),
      ));
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.accentColor],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _TypingDot(delay: i * 200)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPrompts(ThemeData theme) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _quickPrompts.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref.read(chatbotControllerProvider.notifier)
                  .sendMessage(_quickPrompts[index]);
              _scrollToBottom();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _quickPrompts[index],
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea(ThemeData theme, bool isLoading) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16, 10, 16,
        MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.strokeColor),
              ),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                onSubmitted: (_) => _send(),
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                style: const TextStyle(fontSize: 14.5),
                decoration: InputDecoration(
                  hintText: 'Posez votre question sur les ravageurs…',
                  hintStyle: TextStyle(
                    color: AppTheme.mutedTextColor,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: isLoading ? null : _send,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isLoading
                    ? null
                    : LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.accentColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: isLoading ? Colors.grey[300] : null,
                shape: BoxShape.circle,
                boxShadow: isLoading
                    ? []
                    : [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: Center(
                        child: SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// Animated typing dot
class _TypingDot extends StatefulWidget {
  final int delay;
  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _timer = Timer(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
    _anim = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: FadeTransition(
        opacity: _anim,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
