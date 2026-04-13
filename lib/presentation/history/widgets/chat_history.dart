import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellbot/data/models/chat_history_model.dart';
import 'package:wellbot/core/utils/constants/app_colors.dart';
import 'package:wellbot/core/utils/theme/custom_text_style.dart';

class ChatHistoryListItem extends StatelessWidget {
  final ChatHistoryItemModel item;
  final VoidCallback onTap;

  const ChatHistoryListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  String _formatTime(DateTime dateTime) {
    final localDateTime = dateTime.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localDateTime);

    if (difference.inDays == 0) {
      return DateFormat('h:mm a').format(localDateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} Days Ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(1.4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(17),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Image.asset(
                    item.coachImageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.coachTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.semiBold16DarkGreyDense,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.regular14Grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _formatTime(item.lastMessageTime),
                style: CustomTextStyles.regular14Grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
