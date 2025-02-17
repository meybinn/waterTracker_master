import 'package:flutter/material.dart';
import 'package:water_tracker/features/home_screen.dart';
import 'package:water_tracker/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const WaterTracker());
}

class WaterTracker extends StatelessWidget {
  const WaterTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomeScreen(),
    );
  }
}
