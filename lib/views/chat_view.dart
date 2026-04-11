import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';
import 'package:wellbot/utils/constants/app_colors.dart';
import 'package:wellbot/utils/theme/custom_text_style.dart';

class ChatScreen extends StatelessWidget {
  final CoachCategoryModel coach;

  const ChatScreen({
    super.key,
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          coach.title,
          style: CustomTextStyles.orelegaOne32White,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Text(
          '${coach.title} chat sayfası',
          style: CustomTextStyles.semiBold16DarkGreyDense,
        ),
      ),
    );
  }
}