import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';

import 'package:water_tracker/features/signup_screen.dart';
import 'package:water_tracker/features/start_screen.dart';

import 'package:water_tracker/intake_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IntakeProvider(),
      child: const WaterTracker(),
    ),
  );
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF7C7C7C),
        scaffoldBackgroundColor: const Color(0xFFE0E6FE),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE0E6FE),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xFFE0E6FE),
        ),
      ),
      home: MainNavigationScreen(tab: "setting"),
      // home: StartScreen(),
      // home: HistoryScreen(),
      // home: MainNavigationScreen(tab: "add"),
      // home: HomeScreen(),
      // home: SigninScreen(),
      // home: StartScreen(),
      // home: SignupScreen(),
      // home: const SetupProfileScreen(),
      // home: SettingScreen(),
      // home: HistoryScreen(),
      // home: SetUpGoalScreen(),
    );
  }
}
