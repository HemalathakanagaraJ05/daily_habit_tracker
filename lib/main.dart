import 'package:daily_habit_tracker/firebase_options.dart';
import 'package:daily_habit_tracker/modules/auth_module/view/about_profile_screen.dart';
import 'package:daily_habit_tracker/modules/auth_module/view/login_scren.dart';
import 'package:daily_habit_tracker/modules/Home_module/view/home_screen.dart';
// import 'package:daily_habit_tracker/models/view/login_scren.dart';
import 'package:daily_habit_tracker/modules/auth_module/view/spelash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const DailyHabitApp());
}

class DailyHabitApp extends StatefulWidget {
  const DailyHabitApp({super.key});

  @override
  State<DailyHabitApp> createState() => _DailyHabitAppState();
}

class _DailyHabitAppState extends State<DailyHabitApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),

      // Theme selection
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Starting screen
      home: const SplashScreen(),

      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
      },
    );
  }
}
