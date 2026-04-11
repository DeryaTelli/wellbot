enum SenderType {
  user,
  bot,
}

class ChatMessageModel {
  final String id;
  final String conversationId;
  final String coachId;
  final String text;
  final SenderType sender;
  final DateTime createdAt;

  const ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.coachId,
    required this.text,
    required this.sender,
    required this.createdAt,
  });
}