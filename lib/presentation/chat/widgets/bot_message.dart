import 'package:flutter/material.dart';
import 'package:wellbot/core/utils/constants/app_colors.dart';
import 'package:wellbot/data/models/chat_message_model.dart';
import 'package:wellbot/core/utils/theme/custom_text_style.dart';

class BotMessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  const BotMessageBubble({super.key, required this.message});

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
              radius: 24,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/chatbox.png'),
            ),
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 240),
              decoration: BoxDecoration(
                gradient: AppColors.backgroundGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Text(
                  message.text,
                  style: CustomTextStyles.regular15Black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
