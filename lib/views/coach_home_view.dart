import 'package:flutter/material.dart';
import 'package:wellbot/utils/constants/app_colors.dart';
import 'package:wellbot/utils/widgets/home_widgets/coaches_grid.dart';
import 'package:wellbot/utils/widgets/navbar/bottom_nav_bar.dart';
import 'package:wellbot/viewmodels/coach_home_viewmodel.dart';

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
      appBar: AppBar(title: const Text('Wellbot Coaches')),
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
