import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/data/models/chat_message_model.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/data/repositories/chat_repository.dart';

class ChatState {
  final bool isLoading;
  final List<ChatMessageModel> messages;
  final String? error;

  const ChatState({
    required this.isLoading,
    required this.messages,
    this.error,
  });

  factory ChatState.initial() {
    return const ChatState(isLoading: false, messages: [], error: null);
  }

  ChatState copyWith({
    bool? isLoading,
    List<ChatMessageModel>? messages,
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      error: error,
    );
  }
}

class ChatCubit extends Cubit<ChatState> {
  final CoachCategoryModel coach;
  final ChatRepository repository;
  final String? initialConversationId;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late final String conversationId;

  ChatCubit({
    required this.coach,
    required this.repository,
    this.initialConversationId,
  }) : super(ChatState.initial());

  Future<void> init() async {
    conversationId =
        initialConversationId ??
        DateTime.now().millisecondsSinceEpoch.toString();

    if (initialConversationId != null) {
      final oldMessages = await repository.getMessagesByConversation(
        conversationId,
      );

      emit(state.copyWith(messages: oldMessages));
      return;
    }

    final welcomeMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      coachId: coach.id,
      text: _welcomeMessageForCoach(),
      sender: SenderType.bot,
      createdAt: DateTime.now(),
    );

    // Sadece ekranda göster, veritabanına yazma
    emit(state.copyWith(messages: [welcomeMessage]));
  }

  String _welcomeMessageForCoach() {
    switch (coach.id) {
      case 'dietitian':
        return 'Welcome! I am your Dietitian. Ask me anything about nutrition, meal plans, and healthy eating.';
      case 'fitness':
        return 'Welcome! I am your Fitness Coach. Ask me about workouts, strength, and training plans.';
      case 'yoga':
        return 'Welcome! I am your Yoga Instructor. Ask me about breathing, posture, and flexibility.';
      case 'pilates':
        return 'Welcome! I am your Pilates Coach. Ask me about posture, core strength, and safe movement.';
      default:
        return 'Welcome! How can I help you today?';
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessageModel(
      id: '${DateTime.now().microsecondsSinceEpoch}_user',
      conversationId: conversationId,
      coachId: coach.id,
      text: text,
      sender: SenderType.user,
      createdAt: DateTime.now(),
    );

    await repository.saveMessage(userMessage);

    final updatedMessages = [...state.messages, userMessage];
    emit(
      state.copyWith(messages: updatedMessages, isLoading: true, error: null),
    );
    messageController.clear();

    try {
      final aiResponse = await repository.getAiResponse(
        coach: coach,
        messages: updatedMessages,
        userMessage: text,
      );

      final botMessage = ChatMessageModel(
        id: '${DateTime.now().microsecondsSinceEpoch}_bot',
        conversationId: conversationId,
        coachId: coach.id,
        text: aiResponse,
        sender: SenderType.bot,
        createdAt: DateTime.now(),
      );

      await repository.saveMessage(botMessage);

      emit(
        state.copyWith(
          messages: [...updatedMessages, botMessage],
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
