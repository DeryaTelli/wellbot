import 'package:flutter/material.dart';
import 'package:wellbot/core/widgets/home_widgets/coaches_grid.dart';
import 'package:wellbot/core/widgets/navbar/bottom_nav_bar.dart';
import 'package:wellbot/viewmodels/coach_home_viewmodel.dart';
import '../../../core/theme/app_colors.dart';


class CoachesHomePage extends StatefulWidget {
  const CoachesHomePage({super.key});

  @override
  State<CoachesHomePage> createState() => _CoachesHomePageState();
}

class _CoachesHomePageState extends State<CoachesHomePage> {
  late final CoachesHomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CoachesHomeViewModel();
    viewModel.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    viewModel.removeListener(_refresh);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: viewModel.selectedBottomIndex,
        onTap: viewModel.changeBottomTab,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'WellnessAI - Choose Your Expert',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: CoachesGrid(viewModel: viewModel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}