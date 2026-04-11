import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wellbot/core/utils/theme/app_theme.dart';
import 'package:wellbot/data/local/db/app_database.dart';
import 'package:wellbot/firebase_options.dart';
import 'package:wellbot/presentation/coaches/views/coach_home_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AppDatabase.instance.init();

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