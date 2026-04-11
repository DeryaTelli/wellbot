import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wellbot/utils/constants/app_colors.dart';
import 'package:wellbot/utils/theme/custom_text_style.dart';
import 'package:wellbot/models/coaches_category_model.dart';

class CoachCategoryCard extends StatelessWidget {
  final CoachCategoryModel category;
  final VoidCallback onTap;

  const CoachCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.asset(
                  category.lottieAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.spa, size: 44);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: CustomTextStyles.semiBold16DarkGreyDense,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
