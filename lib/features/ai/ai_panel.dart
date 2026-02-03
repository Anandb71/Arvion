import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../providers/providers.dart';
import '../../services/ai_service.dart';
import 'widgets/chat_bubble.dart';

class AIPanel extends ConsumerStatefulWidget {
  const AIPanel({super.key});

  @override
  ConsumerState<AIPanel> createState() => _AIPanelState();
}

class _AIPanelState extends ConsumerState<AIPanel> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  final List<AIMessage> _messages = [];
  bool _isTyping = false;
  String _currentStreamedResponse = '';

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
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

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = AIMessage(content: text, isUser: true);
    setState(() {
      _messages.add(userMsg);
      _inputController.clear();
      _isTyping = true;
      _currentStreamedResponse = '';
    });
    _scrollToBottom();

    try {
      final service = ref.read(aiServiceProvider);
      // Listen to the stream
      await for (final chunk in service.sendMessageStream(text)) {
        setState(() {
          _currentStreamedResponse += chunk;
        });
        _scrollToBottom();
      }

      // Finalize message
      setState(() {
        _messages.add(AIMessage(content: _currentStreamedResponse, isUser: false));
        _currentStreamedResponse = '';
        _isTyping = false;
      });
      _scrollToBottom();
      
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add(AIMessage(
          content: "Error: Unable to connect to AI service.",
          isUser: false,
        ));
      });
    }
  }

  void _onQuickAction(String action) {
    _sendMessage(action);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Arvion background
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ArvionColors.border, width: 0.5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: ArvionColors.primary, size: 28),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assistant',
                      style: ArvionTypography.headlineMedium.copyWith(color: ArvionColors.textPrimary),
                    ),
                    Text(
                      'Powered by Arvion Intelligence (Beta)',
                      style: ArvionTypography.labelSmall.copyWith(color: ArvionColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chat Area
          Expanded(
            child: _messages.isEmpty && !_isTyping
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(24),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _messages.length) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ChatBubble(message: _messages[index]),
                        );
                      } else {
                        // Streaming response bubble
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ChatBubble(
                            message: AIMessage(
                              content: _currentStreamedResponse.isEmpty ? '...' : _currentStreamedResponse,
                              isUser: false,
                            ),
                          ),
                        );
                      }
                    },
                  ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: ArvionColors.border, width: 0.5)),
              color: ArvionColors.surface,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    style: const TextStyle(color: ArvionColors.textPrimary),
                    enabled: !_isTyping,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Ask anything about your tasks...',
                      hintStyle: const TextStyle(color: ArvionColors.textSecondary),
                      filled: true,
                      fillColor: ArvionColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filled(
                  onPressed: _isTyping ? null : () => _sendMessage(_inputController.text),
                  icon: _isTyping 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: ArvionColors.textMuted))
                    : const Icon(Icons.send_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: ArvionColors.primary,
                    foregroundColor: ArvionColors.background,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_outlined, size: 64, color: ArvionColors.textMuted.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            'How can I help you today?',
            style: ArvionTypography.titleMedium.copyWith(color: ArvionColors.textSecondary),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _QuickActionChip(
                label: 'Suggest tasks for today',
                icon: Icons.lightbulb_outline,
                onTap: () => _onQuickAction('Suggest tasks for today'),
              ),
              _QuickActionChip(
                label: 'Review my weekly progress',
                icon: Icons.insights_outlined,
                onTap: () => _onQuickAction('Review my weekly progress'),
              ),
              _QuickActionChip(
                label: 'Help me plan a project',
                icon: Icons.list_alt,
                onTap: () => _onQuickAction('Help me plan a project'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: ArvionColors.primary),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: ArvionColors.surfaceLight,
      side: const BorderSide(color: ArvionColors.border),
      labelStyle: const TextStyle(color: ArvionColors.textPrimary),
      padding: const EdgeInsets.all(8),
    );
  }
}
