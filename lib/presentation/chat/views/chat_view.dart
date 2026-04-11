import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/data/local/datasources/chat_datasource.dart';

import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/core/utils/constants/app_colors.dart';
import 'package:wellbot/data/remote/datasource/ai_chat_datasource.dart';
import 'package:wellbot/data/remote/datasource/remote_config_datasource.dart';
import 'package:wellbot/data/repositories/chat_repository.dart';
import 'package:wellbot/presentation/chat/widgets/chat_input_bar.dart';
import 'package:wellbot/presentation/chat/widgets/chat_message_list.dart';
import 'package:wellbot/presentation/chat/cubit/chat_viewmodel.dart';

class ChatScreen extends StatelessWidget {
  final CoachCategoryModel coach;
  final String? conversationId;

  const ChatScreen({super.key, required this.coach, this.conversationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        coach: coach,
        initialConversationId: conversationId,
        repository: ChatRepository(
          localDataSource: ChatLocalDataSource(),
          remoteConfigDataSource: RemoteConfigDataSource(),
          aiChatDataSource: AiChatDataSource(),
        ),
      )..init(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          title: Text(coach.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 1.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  final cubit = context.read<ChatCubit>();

                  return Column(
                    children: [
                      Expanded(
                        child: ChatMessageList(
                          messages: state.messages,
                          scrollController: cubit.scrollController,
                        ),
                      ),
                      if (state.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text('Yazıyor...'),
                        ),
                      ChatInputBar(
                        controller: cubit.messageController,
                        onSend: cubit.sendMessage,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
