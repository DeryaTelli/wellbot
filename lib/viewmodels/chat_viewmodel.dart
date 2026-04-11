import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_message_model.dart';
import 'package:wellbot/models/coaches_category_model.dart';
import 'package:wellbot/services/chat_history_service.dart';

class ChatViewModel extends ChangeNotifier {
  final CoachCategoryModel coach;

  ChatViewModel({required this.coach}) {
    _messages = List.from(
      ChatHistoryService.instance.getMessagesByCoach(coach.id),
    );

    if (_messages.isEmpty) {
      final welcomeMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        coachId: coach.id,
        text: '${coach.title} ile görüşmeye hoş geldin.',
        sender: SenderType.bot,
        createdAt: DateTime.now(),
      );

      _messages.add(welcomeMessage);
      ChatHistoryService.instance.addMessage(welcomeMessage);
    }
  }

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late List<ChatMessageModel> _messages;

  List<ChatMessageModel> get messages => _messages;

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      coachId: coach.id,
      text: text,
      sender: SenderType.user,
      createdAt: DateTime.now(),
    );

    _messages.add(userMessage);
    ChatHistoryService.instance.addMessage(userMessage);

    messageController.clear();
    notifyListeners();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 400), () {
      final botMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        coachId: coach.id,
        text: '${coach.title} sana yardımcı oluyor.',
        sender: SenderType.bot,
        createdAt: DateTime.now(),
      );

      _messages.add(botMessage);
      ChatHistoryService.instance.addMessage(botMessage);
      notifyListeners();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}