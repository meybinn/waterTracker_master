import 'package:flutter/material.dart';
import 'package:water_tracker/features/home_screen.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/features/setup_profile_screen.dart';
import 'package:water_tracker/features/signIn_screen.dart';

import 'package:water_tracker/features/signup_screen.dart';
import 'package:water_tracker/features/start_screen.dart';

void main() {
  runApp(const WaterTracker());
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
        home: MainNavigationScreen(tab: "home")
        // home: HomeScreen()
        // home: SigninScreen()
        // home: StartScreen(),
        // home: SignupScreen(),
        // home: const SetupProfileScreen(),
        );
  }
}
