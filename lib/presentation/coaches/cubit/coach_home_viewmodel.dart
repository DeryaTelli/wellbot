import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/data/models/coaches_category_model.dart';
import 'package:wellbot/data/repositories/coach_repository.dart';

class CoachesState {
  final List<CoachCategoryModel> categories;

  const CoachesState({
    required this.categories,
  });

  factory CoachesState.initial() {
    return const CoachesState(
      categories: CoachRepository.coaches,
    );
  }
}

class CoachesCubit extends Cubit<CoachesState> {
  CoachesCubit() : super(CoachesState.initial());
}