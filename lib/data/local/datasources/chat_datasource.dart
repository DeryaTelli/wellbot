import 'package:wellbot/data/local/db/app_database.dart';
import 'package:wellbot/data/models/chat_history_model.dart';
import 'package:wellbot/data/models/chat_message_model.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';

class ChatLocalDataSource {
  Future<void> insertMessage(ChatMessageModel message) async {
    await AppDatabase.instance.database.insert(
      'chat_messages',
      {
        'id': message.id,
        'conversation_id': message.conversationId,
        'coach_id': message.coachId,
        'text': message.text,
        'sender': message.sender.name,
        'created_at': message.createdAt.toIso8601String(),
      },
    );
  }

  Future<List<ChatMessageModel>> getMessagesByConversation(
    String conversationId,
  ) async {
    final result = await AppDatabase.instance.database.query(
      'chat_messages',
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
      orderBy: 'created_at ASC',
    );

    return result.map((e) {
      return ChatMessageModel(
        id: e['id'] as String,
        conversationId: e['conversation_id'] as String,
        coachId: e['coach_id'] as String,
        text: e['text'] as String,
        sender: (e['sender'] as String) == 'user'
            ? SenderType.user
            : SenderType.bot,
        createdAt: DateTime.parse(e['created_at'] as String),
      );
    }).toList();
  }

  Future<List<ChatHistoryItemModel>> getHistoryItems(
    Map<String, CoachCategoryModel> coachMap,
  ) async {
    final result = await AppDatabase.instance.database.rawQuery('''
      SELECT m1.conversation_id, m1.coach_id, m1.text, m1.created_at
      FROM chat_messages m1
      INNER JOIN (
        SELECT conversation_id, MAX(created_at) AS max_created_at
        FROM chat_messages
        GROUP BY conversation_id
      ) latest
      ON m1.conversation_id = latest.conversation_id
      AND m1.created_at = latest.max_created_at
      ORDER BY m1.created_at DESC
    ''');

    return result.map((e) {
      final coachId = e['coach_id'] as String;
      final coach = coachMap[coachId];

      if (coach == null) {
        throw Exception('Coach not found for id: $coachId');
      }

      return ChatHistoryItemModel(
        conversationId: e['conversation_id'] as String,
        coachId: coach.id,
        coachTitle: coach.title,
        coachImageAsset: coach.imageAsset,
        lastMessage: e['text'] as String,
        lastMessageTime: DateTime.parse(e['created_at'] as String),
      );
    }).toList();
  }
}