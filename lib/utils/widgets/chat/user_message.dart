import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_message_model.dart';
import 'package:wellbot/utils/theme/custom_text_style.dart';


class UserMessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  const UserMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 210),
        margin: const EdgeInsets.only(bottom: 12, left: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEEE0BD),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: CustomTextStyles.regular14Black,
        ),
      ),
    );
  }
}