import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/data/local/datasources/chat_datasource.dart';
import 'package:wellbot/data/models/chat_history_model.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/data/remote/datasource/ai_chat_datasource.dart';
import 'package:wellbot/data/remote/datasource/remote_config_datasource.dart';
import 'package:wellbot/data/repositories/chat_repository.dart';
import 'package:wellbot/data/repositories/coach_repository.dart';

class ChatHistoryState {
  final bool isLoading;
  final List<ChatHistoryItemModel> historyItems;

  const ChatHistoryState({
    required this.isLoading,
    required this.historyItems,
  });

  factory ChatHistoryState.initial() {
    return const ChatHistoryState(
      isLoading: false,
      historyItems: [],
    );
  }

  ChatHistoryState copyWith({
    bool? isLoading,
    List<ChatHistoryItemModel>? historyItems,
  }) {
    return ChatHistoryState(
      isLoading: isLoading ?? this.isLoading,
      historyItems: historyItems ?? this.historyItems,
    );
  }
}

class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  final ChatRepository repository;

  ChatHistoryCubit({required this.repository})
      : super(ChatHistoryState.initial());

  Future<void> init() async {
    await loadHistory();
  }

  Future<void> loadHistory() async {
    emit(state.copyWith(isLoading: true));

    final items = await repository.getHistoryItems(
      CoachRepository.coachMap(),
    );

    emit(
      state.copyWith(
        isLoading: false,
        historyItems: items,
      ),
    );
  }

  CoachCategoryModel coachFromHistoryItem(ChatHistoryItemModel item) {
    return CoachRepository.findById(item.coachId) ??
        CoachCategoryModel(
          id: item.coachId,
          title: item.coachTitle,
          imageAsset: item.coachImageAsset,
          lottieAsset: '',
          remoteConfigKey: '',
        );
  }
}