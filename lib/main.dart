import 'package:daily_habit_tracker/models/view/login_scren.dart';
import 'package:daily_habit_tracker/models/view/spelash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DailyHabitApp());
}

class DailyHabitApp extends StatelessWidget {
  const DailyHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
