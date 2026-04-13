import 'package:flutter/material.dart';
import 'package:wellbot/core/utils/constants/app_colors.dart';
import 'package:wellbot/core/utils/theme/custom_text_style.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.hintTextColor,
      selectedLabelStyle: CustomTextStyles.bold14Primary,
      unselectedLabelStyle: CustomTextStyles.regular14Grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Coaches'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      ],
    );
  }
}
