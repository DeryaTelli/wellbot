import 'package:flutter/material.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/presentation/coaches/widgets/coach_category_card.dart';
import 'package:wellbot/presentation/chat/views/chat_view.dart';

class CoachesGrid extends StatelessWidget {
  final List<CoachCategoryModel> categories;

  const CoachesGrid({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return CoachCategoryCard(
          category: category,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(coach: category),
              ),
            );
          },
        );
      },
    );
  }
}