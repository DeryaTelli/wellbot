enum SenderType { user, bot }

class ChatMessageModel {
  final String id;
  final String text;
  final SenderType sender;
  final DateTime time;
  final bool showQuickActions;
  final List<String> quickActions;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.time,
    this.showQuickActions = false,
    this.quickActions = const [],
  });
}