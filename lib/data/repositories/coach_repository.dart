import 'package:wellbot/data/models/coaches_category_model.dart';

class CoachRepository {
  static const List<CoachCategoryModel> coaches = [
    CoachCategoryModel(
      id: 'dietitian',
      title: 'Dietitian',
      imageAsset: 'assets/images/diet.png',
      lottieAsset: 'assets/lottie/diet.json',
      remoteConfigKey: 'dietitian_system_prompt',
    ),
    CoachCategoryModel(
      id: 'fitness',
      title: 'Fitness Coach',
      imageAsset: 'assets/images/fitness.png',
      lottieAsset: 'assets/lottie/fitness.json',
      remoteConfigKey: 'fitness_system_prompt',
    ),
    CoachCategoryModel(
      id: 'yoga',
      title: 'Yoga Instructor',
      imageAsset: 'assets/images/yoga.png',
      lottieAsset: 'assets/lottie/yoga.json',
      remoteConfigKey: 'yoga_system_prompt',
    ),
    CoachCategoryModel(
      id: 'pilates',
      title: 'Pilates Coach',
      imageAsset: 'assets/images/pilates.png',
      lottieAsset: 'assets/lottie/pilates.json',
      remoteConfigKey: 'pilates_system_prompt',
    ),
  ];

  static Map<String, CoachCategoryModel> coachMap() {
    return {
      for (final coach in coaches) coach.id: coach,
    };
  }

  static CoachCategoryModel? findById(String id) {
    for (final coach in coaches) {
      if (coach.id == id) return coach;
    }
    return null;
  }
}