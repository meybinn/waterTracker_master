import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:water_tracker/features/setup_profile_screen.dart';
import 'package:water_tracker/features/signIn_screen.dart';

import 'package:water_tracker/features/signup_screen.dart';
import 'package:water_tracker/features/start_screen.dart';
=======
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/history_screen.dart';
import 'package:water_tracker/features/home_screen.dart';
import 'package:water_tracker/features/setup_profile_screen.dart';
import 'package:water_tracker/features/signup_screen.dart';
import 'package:water_tracker/features/start_screen.dart';
import 'package:water_tracker/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/providers/set_up_goal_screen.dart';
>>>>>>> Stashed changes

void main() {
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
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
        home: SigninScreen()
        // home: StartScreen(),
        // home: SignupScreen(),
        // home: const SetupProfileScreen(),
        );
=======
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0E6FE),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE0E6FE),  
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xFFE0E6FE),
        ),
      ),
      home: const MainNavigationScreen(),
    );
>>>>>>> Stashed changes
  }
}
