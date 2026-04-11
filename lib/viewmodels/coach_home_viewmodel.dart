import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';

class CoachesHomeViewModel extends ChangeNotifier {
  int _selectedBottomIndex = 0;

  int get selectedBottomIndex => _selectedBottomIndex;

  final List<CoachCategoryModel> _categories = const [
    CoachCategoryModel(
      id: 'dietitian',
      title: 'Dietitian',
      lottieAsset: 'assets/lottie/diet.json',
    ),
    CoachCategoryModel(
      id: 'fitness',
      title: 'Fitness Coach',
      lottieAsset: 'assets/lottie/fitness.json',
    ),
    CoachCategoryModel(
      id: 'yoga',
      title: 'Yoga Instructor',
      lottieAsset: 'assets/lottie/yoga.json',
    ),
    CoachCategoryModel(
      id: 'pilates',
      title: 'Pilates Coach',
      lottieAsset: 'assets/lottie/pilates.json',
    ),
  ];

  List<CoachCategoryModel> get categories => _categories;

  void changeBottomTab(int index) {
    _selectedBottomIndex = index;
    notifyListeners();
  }
}
