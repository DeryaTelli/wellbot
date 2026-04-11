import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';
import 'package:wellbot/utils/constants/app_colors.dart';
import 'package:wellbot/utils/widgets/chat/chat_input_bar.dart';
import 'package:wellbot/utils/widgets/chat/chat_message_list.dart';
import 'package:wellbot/viewmodels/chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  final CoachCategoryModel coach;

  const ChatScreen({
    super.key,
    required this.coach,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ChatViewModel();
    viewModel.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    viewModel.removeListener(_refresh);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(widget.coach.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 1.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ChatMessageList(
                    messages: viewModel.messages,
                    scrollController: viewModel.scrollController,
                    onQuickActionTap: viewModel.onQuickActionTap,
                  ),
                ),
                ChatInputBar(
                  controller: viewModel.messageController,
                  onSend: viewModel.sendMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}