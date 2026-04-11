import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';


class CoachesHomeViewModel extends ChangeNotifier {
  int _selectedBottomIndex = 0;

  int get selectedBottomIndex => _selectedBottomIndex;

  final List<CoachCategoryModel> _categories = const [
    CoachCategoryModel(
      title: 'Dietitian',
      imageAsset: 'assets/icons/dietitian.png',
    ),
    CoachCategoryModel(
      title: 'Fitness Coach',
      imageAsset: 'assets/icons/fitness.png',
    ),
    CoachCategoryModel(
      title: 'Yoga Instructor',
      imageAsset: 'assets/icons/yoga.png',
    ),
    CoachCategoryModel(
      title: 'Pilates Coach',
      imageAsset: 'assets/icons/pilates.png',
    ),
  ];

  List<CoachCategoryModel> get categories => _categories;

  void changeBottomTab(int index) {
    _selectedBottomIndex = index;
    notifyListeners();
  }

  void onCategoryTap(CoachCategoryModel category) {
    debugPrint('${category.title} seçildi');
  }
}