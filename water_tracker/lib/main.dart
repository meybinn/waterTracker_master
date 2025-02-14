import 'package:flutter/material.dart';

import 'package:water_tracker/features/signup_screen.dart';

void main() {
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0E6FE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE0E6FE),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xFFE0E6FE),
        ),
      ),
      home: const SignupScreen(),
    );
  }
}
