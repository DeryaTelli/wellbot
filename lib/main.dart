import 'package:flutter/material.dart';
import 'package:wellbot/views/coach_home_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wellness AI',
      home: const CoachesHomePage(),
    );
  }
}