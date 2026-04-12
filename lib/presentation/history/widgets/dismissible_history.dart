import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/core/utils/theme/custom_text_style.dart';
import 'package:wellbot/data/models/chat_history_model.dart';
import 'package:wellbot/presentation/chat/views/chat_view.dart';
import 'package:wellbot/presentation/history/cubit/chat_history_viewmodel.dart';
import 'package:wellbot/presentation/history/widgets/chat_history.dart';

class DismissibleHistoryItem extends StatelessWidget {
  final ChatHistoryItemModel item;

  const DismissibleHistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatHistoryCubit>();

    return Dismissible(
      key: ValueKey(item.conversationId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: const Text('Delete chat'),
                  titleTextStyle: CustomTextStyles.orelegaOne32Primary,
                  content: const Text(
                    'Do you want to delete this conversation?',
                  ),
                  contentTextStyle: CustomTextStyles.semiBold14DarkGrey,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: Text('Cancel'),
                      style: TextButton.styleFrom(
                        textStyle: CustomTextStyles.semiBold16Primary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: const Text('Delete'),
                      style: TextButton.styleFrom(
                        textStyle: CustomTextStyles.semiBold16Primary,
                      ),
                    ),
                  ],
                );
              },
            ) ??
            false;
      },
      onDismissed: (_) async {
        await cubit.deleteConversation(item.conversationId);

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Conversation deleted')));
        }
      },
      child: ChatHistoryListItem(
        item: item,
        onTap: () {
          final coach = cubit.coachFromHistoryItem(item);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ChatScreen(coach: coach, conversationId: item.conversationId),
            ),
          ).then((_) {
            cubit.loadHistory();
          });
        },
      ),
    );
  }
}
