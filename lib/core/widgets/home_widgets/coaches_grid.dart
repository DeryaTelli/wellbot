import 'package:flutter/material.dart';
import 'package:wellbot/viewmodels/coach_home_viewmodel.dart';
import 'coach_category_card.dart';

class CoachesGrid extends StatelessWidget {
  final CoachesHomeViewModel viewModel;

  const CoachesGrid({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: viewModel.categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final category = viewModel.categories[index];

        return CoachCategoryCard(
          category: category,
          onTap: () => viewModel.onCategoryTap(category),
        );
      },
    );
  }
}