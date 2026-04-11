import 'package:wellbot/models/chat_history_model.dart';
import 'package:wellbot/models/chat_message_model.dart';
import 'package:wellbot/models/coaches_category_model.dart';

class ChatHistoryService {
  ChatHistoryService._();
  static final ChatHistoryService instance = ChatHistoryService._();

  final List<ChatMessageModel> _allMessages = [];
  final Map<String, CoachCategoryModel> _coachMap = {};
  bool _seeded = false;

  void registerCoach(CoachCategoryModel coach) {
    _coachMap[coach.id] = coach;
  }

  void addMessage(ChatMessageModel message) {
    _allMessages.add(message);
  }

  List<ChatMessageModel> getMessagesByCoach(String coachId) {
    return _allMessages.where((e) => e.coachId == coachId).toList();
  }

  void seedDemoData() {
    if (_seeded) return;
    _seeded = true;

    _allMessages.addAll([
      ChatMessageModel(
        id: '1',
        coachId: 'dietitian',
        text: 'How many calories did you eat today?',
        sender: SenderType.bot,
        createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessageModel(
        id: '2',
        coachId: 'fitness',
        text: 'Never give up! Tomorrow is another workout day.',
        sender: SenderType.bot,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      ChatMessageModel(
        id: '3',
        coachId: 'yoga',
        text: 'Don\'t forget the breathing exercises.',
        sender: SenderType.bot,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ]);
  }

  List<ChatHistoryItemModel> getHistoryItems() {
    final Map<String, List<ChatMessageModel>> grouped = {};

    for (final message in _allMessages) {
      grouped.putIfAbsent(message.coachId, () => []);
      grouped[message.coachId]!.add(message);
    }

    final List<ChatHistoryItemModel> history = [];

    grouped.forEach((coachId, messages) {
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final lastMessage = messages.first;
      final coach = _coachMap[coachId];

      if (coach != null) {
        history.add(
          ChatHistoryItemModel(
            coachId: coach.id,
            coachTitle: coach.title,
            coachImageAsset: coach.imageAsset,
            lastMessage: lastMessage.text,
            lastMessageTime: lastMessage.createdAt,
          ),
        );
      }
    });

    history.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    return history;
  }
}
