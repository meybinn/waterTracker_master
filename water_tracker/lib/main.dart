import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/features/history_screen.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/features/setup_profile_screen.dart';
import 'package:water_tracker/features/start_screen.dart';

import 'package:water_tracker/intake_provider.dart';
import 'package:water_tracker/notification/notification.dart';
import 'package:water_tracker/providers/set_up_goal_screen.dart';
import 'package:water_tracker/setting/setting_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IntakeProvider(),
      child: const WaterTracker(),
    ),
  );
}

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  @override
  void initState() {
    FlutterLocalNotification.init();

    Future.delayed(Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());

    super.initState();
  }

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

      // home: StartScreen(),
      // home: HistoryScreen(),
      home: MainNavigationScreen(tab: "add"),
      // home: HomeScreen(),
      // home: SigninScreen(),
      // home: StartScreen(),
      // home: SignupScreen(),
      // home: const SetupProfileScreen(),
      // home: SettingScreen(),
      // home: HistoryScreen(),
      // home: SetUpGoalScreen(),
      // home: SettingScreen(),
    );
  }
}