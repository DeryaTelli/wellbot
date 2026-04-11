

import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_message_model.dart';
import 'package:wellbot/utils/widgets/chat/bot_message.dart';
import 'package:wellbot/utils/widgets/chat/user_message.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;
  final ValueChanged<String> onQuickActionTap;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.onQuickActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        if (message.sender == SenderType.user) {
          return UserMessageBubble(message: message);
        }

        return BotMessageBubble(
          message: message,
          onQuickActionTap: onQuickActionTap,
        );
      },
    );
  }
}