import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../services/ai_service.dart';

class ChatBubble extends StatelessWidget {
  final AIMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Styling constants
    final bool isUser = message.isUser;
    final bgColor = isUser ? ArvionColors.primary.withValues(alpha: 0.15) : ArvionColors.surfaceLight;
    final borderColor = isUser ? ArvionColors.primary.withValues(alpha: 0.3) : ArvionColors.border;
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isUser ? 16 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 16),
            ),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.smart_toy_outlined, size: 14, color: ArvionColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'ASSISTANT',
                      style: ArvionTypography.labelSmall.copyWith(
                        color: ArvionColors.primary,
                        fontSize: 10,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              
              MarkdownBody(
                data: message.content,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  p: ArvionTypography.bodyMedium.copyWith(color: ArvionColors.textPrimary),
                  strong: ArvionTypography.bodyMedium.copyWith(
                    color: ArvionColors.textPrimary, 
                    fontWeight: FontWeight.bold,
                  ),
                  listBullet: const TextStyle(color: ArvionColors.primary),
                  code: ArvionTypography.monoSmall.copyWith(
                    backgroundColor: ArvionColors.background,
                    color: ArvionColors.secondary,
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: ArvionColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ArvionColors.border),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatTime(message.timestamp),
          style: ArvionTypography.labelSmall.copyWith(
            color: ArvionColors.textMuted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
