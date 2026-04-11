import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbot/presentation/coaches/widgets/coaches_grid.dart';
import 'package:wellbot/core/utils/widgets/navbar/bottom_nav_bar.dart';
import 'package:wellbot/presentation/coaches/cubit/coach_home_viewmodel.dart';
import 'package:wellbot/presentation/history/views/chat_history_view.dart';

class CoachesHomePage extends StatelessWidget {
  const CoachesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoachesCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Wellbot Coaches')),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatHistoryPage(),
                ),
              );
            }
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocBuilder<CoachesCubit, CoachesState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CoachesGrid(categories: state.categories),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}