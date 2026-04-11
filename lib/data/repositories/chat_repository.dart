import 'package:wellbot/data/local/datasources/chat_datasource.dart';
import 'package:wellbot/data/models/chat_history_model.dart';
import 'package:wellbot/data/models/chat_message_model.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/data/remote/datasource/ai_chat_datasource.dart';
import 'package:wellbot/data/remote/datasource/remote_config_datasource.dart';

class ChatRepository {
  final ChatLocalDataSource localDataSource;
  final RemoteConfigDataSource remoteConfigDataSource;
  final AiChatDataSource aiChatDataSource;

  ChatRepository({
    required this.localDataSource,
    required this.remoteConfigDataSource,
    required this.aiChatDataSource,
  });

  Future<List<ChatMessageModel>> getMessagesByConversation(
    String conversationId,
  ) {
    return localDataSource.getMessagesByConversation(conversationId);
  }

  Future<void> saveMessage(ChatMessageModel message) {
    return localDataSource.insertMessage(message);
  }

  Future<List<ChatHistoryItemModel>> getHistoryItems(
    Map<String, CoachCategoryModel> coachMap,
  ) {
    return localDataSource.getHistoryItems(coachMap);
  }

  Future<String> getSystemPrompt(CoachCategoryModel coach) async {
    await remoteConfigDataSource.init();
    return remoteConfigDataSource.getPrompt(coach.remoteConfigKey);
  }

  Future<String> getAiResponse({
    required CoachCategoryModel coach,
    required List<ChatMessageModel> messages,
    required String userMessage,
  }) async {
    final prompt = await getSystemPrompt(coach);

    final history = messages.map((m) {
      return {
        'role': m.sender == SenderType.user ? 'user' : 'assistant',
        'text': m.text,
      };
    }).toList();

    return aiChatDataSource.sendMessage(
      systemPrompt: prompt,
      history: history,
      userMessage: userMessage,
    );
  }
}