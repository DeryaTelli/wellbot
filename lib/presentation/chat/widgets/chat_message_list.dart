import 'package:flutter/material.dart';
import 'package:wellbot/data/models/chat_message_model.dart';
import 'package:wellbot/presentation/chat/widgets/bot_message.dart';
import 'package:wellbot/presentation/chat/widgets/user_message.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.scrollController,
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

        return BotMessageBubble(message: message);
      },
    );
  }
}