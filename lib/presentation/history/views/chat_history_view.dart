import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/data/local/datasources/chat_datasource.dart';
import 'package:wellbot/data/remote/datasource/ai_chat_datasource.dart';
import 'package:wellbot/data/remote/datasource/remote_config_datasource.dart';
import 'package:wellbot/data/repositories/chat_repository.dart';
import 'package:wellbot/presentation/history/widgets/chat_history.dart';
import 'package:wellbot/core/utils/widgets/navbar/bottom_nav_bar.dart';
import 'package:wellbot/presentation/history/cubit/chat_history_viewmodel.dart';
import 'package:wellbot/presentation/chat/views/chat_view.dart';
import 'package:wellbot/presentation/coaches/views/coach_home_view.dart';
import 'package:wellbot/presentation/history/widgets/dismissible_history.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatHistoryCubit(
        repository: ChatRepository(
          localDataSource: ChatLocalDataSource(),
          remoteConfigDataSource: RemoteConfigDataSource(),
          aiChatDataSource: AiChatDataSource(),
        ),
      )..init(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat History')),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CoachesHomePage()),
              );
            }
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.historyItems.isEmpty) {
                  return const Center(child: Text('No chat history found.'));
                }
                return ListView.separated(
                  itemCount: state.historyItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = state.historyItems[index];
                    return DismissibleHistoryItem(item: item);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
