import 'package:flutter/material.dart';
import 'package:wellbot/views/coach_home_view.dart';
import 'utils/theme/app_theme.dart';


void main() {
  runApp(const WellbotApp());
}

class WellbotApp extends StatelessWidget {
  const WellbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wellbot',
      theme: AppTheme.lightTheme,
      home: const CoachesHomePage(),
    );
  }
}