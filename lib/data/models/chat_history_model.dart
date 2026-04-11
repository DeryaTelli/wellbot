class ChatHistoryItemModel {
  final String conversationId;
  final String coachId;
  final String coachTitle;
  final String coachImageAsset;
  final String lastMessage;
  final DateTime lastMessageTime;

  const ChatHistoryItemModel({
    required this.conversationId,
    required this.coachId,
    required this.coachTitle,
    required this.coachImageAsset,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}