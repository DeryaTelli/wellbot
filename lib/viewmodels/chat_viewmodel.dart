import 'package:flutter/material.dart';
import 'package:wellbot/models/chat_message_model.dart';


class ChatViewModel extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      id: '1',
      text:
          'Merhaba!\nBen Yemo uygun ürünlerimiz, siparişlerin ve merak ettiklerin için buradayım. Bugün sana hangi konuda yardımcı olmamı istersin? Hadi seçimini yap, sana rehberlik edeyim!',
      sender: SenderType.bot,
      time: DateTime.now(),
      showQuickActions: true,
      quickActions: [
        'Rezervasyon',
        'Popüler İlanlar',
        'Diğer',
      ],
    ),
  ];

  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    _messages.add(
      ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        sender: SenderType.user,
        time: DateTime.now(),
      ),
    );

    messageController.clear();
    notifyListeners();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 500), () {
      _messages.add(
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: 'Merhaba nasıl yardımcı olabilirim ?',
          sender: SenderType.bot,
          time: DateTime.now(),
        ),
      );
      notifyListeners();
      _scrollToBottom();
    });
  }

  void onQuickActionTap(String action) {
    _messages.add(
      ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: action,
        sender: SenderType.user,
        time: DateTime.now(),
      ),
    );

    notifyListeners();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 400), () {
      _messages.add(
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '$action için yardımcı olabilirim.',
          sender: SenderType.bot,
          time: DateTime.now(),
        ),
      );
      notifyListeners();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 120,
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