import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';
import 'package:wellbot/services/chat_history_service.dart';

class CoachesHomeViewModel extends ChangeNotifier {
  CoachesHomeViewModel() {
    for (final coach in _categories) {
      ChatHistoryService.instance.registerCoach(coach);
    }
    ChatHistoryService.instance.seedDemoData();
  }

  final List<CoachCategoryModel> _categories = const [
    CoachCategoryModel(
      id: 'dietitian',
      title: 'Dietitian',
      imageAsset: 'assets/images/diet.png',
      lottieAsset: 'assets/lottie/diet.json',
    ),
    CoachCategoryModel(
      id: 'fitness',
      title: 'Fitness Coach',
      imageAsset: 'assets/images/fitness.png',
      lottieAsset: 'assets/lottie/fitness.json',
    ),
    CoachCategoryModel(
      id: 'yoga',
      title: 'Yoga Instructor',
      imageAsset: 'assets/images/yoga.png',
      lottieAsset: 'assets/lottie/yoga.json',
    ),
    CoachCategoryModel(
      id: 'pilates',
      title: 'Pilates Coach',
      imageAsset: 'assets/images/pilates.png',
      lottieAsset: 'assets/lottie/pilates.json',
    ),
  ];

  List<CoachCategoryModel> get categories => _categories;
}