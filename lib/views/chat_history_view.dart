import 'package:flutter/material.dart';
import 'package:wellbot/models/coaches_category_model.dart';
import 'package:wellbot/services/chat_history_service.dart';
import 'package:wellbot/utils/widgets/history/chat_history.dart';
import 'package:wellbot/utils/widgets/navbar/bottom_nav_bar.dart';
import 'package:wellbot/viewmodels/chat_history_viewmodel.dart';
import 'package:wellbot/views/chat_view.dart';
import 'package:wellbot/views/coach_home_view.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  late final ChatHistoryViewModel viewModel;

  @override
  void initState() {
    super.initState();

    ChatHistoryService.instance.registerCoach(
      const CoachCategoryModel(
        id: 'dietitian',
        title: 'Dietitian',
        imageAsset: 'assets/images/diet.png',
        lottieAsset: 'assets/lottie/diet.json',
      ),
    );

    ChatHistoryService.instance.registerCoach(
      const CoachCategoryModel(
        id: 'fitness',
        title: 'Fitness Coach',
        imageAsset: 'assets/images/fitness.png',
        lottieAsset: 'assets/lottie/fitness.json',
      ),
    );

    ChatHistoryService.instance.registerCoach(
      const CoachCategoryModel(
        id: 'yoga',
        title: 'Yoga Instructor',
        imageAsset: 'assets/images/yoga.png',
        lottieAsset: 'assets/lottie/yoga.json',
      ),
    );

    ChatHistoryService.instance.seedDemoData();

    viewModel = ChatHistoryViewModel();
    viewModel.addListener(_refresh);
    viewModel.loadHistory();
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
      appBar: AppBar(title: const Text('Chat History')),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CoachesHomePage()),
            );
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: viewModel.historyItems.isEmpty
              ? const Center(child: Text('Henüz konuşma yok'))
              : ListView.separated(
                  itemCount: viewModel.historyItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = viewModel.historyItems[index];

                    return ChatHistoryListItem(
                      item: item,
                      onTap: () {
                        final coach = CoachCategoryModel(
                          id: item.coachId,
                          title: item.coachTitle,
                          imageAsset: item.coachImageAsset,
                          lottieAsset: '',
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(coach: coach),
                          ),
                        ).then((_) {
                          viewModel.loadHistory();
                        });
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}