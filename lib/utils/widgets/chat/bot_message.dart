import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_message_model.dart';
import 'package:wellbot/utils/theme/custom_text_style.dart';
import 'quick_action_buttons.dart';

class BotMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final ValueChanged<String> onQuickActionTap;

  const BotMessageBubble({
    super.key,
    required this.message,
    required this.onQuickActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/bot_avatar.png',
                errorBuilder: (_, __, ___) => const Icon(Icons.smart_toy),
              ),
            ),
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 240),
              decoration: BoxDecoration(
                color: const Color(0xFFF1A325),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Text(
                      message.text,
                      style: CustomTextStyles.regular14Black,
                    ),
                  ),
                  if (message.showQuickActions)
                    QuickActionButtons(
                      actions: message.quickActions,
                      onTap: onQuickActionTap,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}