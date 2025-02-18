import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/add_intake.dart';
import 'package:water_tracker/features/history_screen.dart';
import 'package:water_tracker/features/home_screen.dart';
import 'package:water_tracker/features/main_navigation/nev_tab.dart';
import 'package:water_tracker/providers/save_goal_screen.dart';
import 'package:water_tracker/setting/setting_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "history",
    "add",
    "goal",
    "setting",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    // context.go("/${_tabs[index]}");

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCE6FF),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: HistoryScreen(),
          ),

          // intake
          Offstage(
            offstage: _selectedIndex != 2,
            child: AddIntake(),
          ),

          // setting goal
          Offstage(
            offstage: _selectedIndex != 3,
            child: SaveGoalScreen(),
          ),

          // setting
          Offstage(
            offstage: _selectedIndex != 4,
            child: SettingScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Sizes.size2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NevTab(
                text: 'home',
                isSelected: _selectedIndex == 0,
                icon: Icons.water_drop,
                onTab: () => _onTap(0),
                selectedIcon: Icons.water_drop,
              ),
              NevTab(
                text: 'history',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.fileLines,
                onTab: () => _onTap(1),
                selectedIcon: FontAwesomeIcons.fileLines,
              ),
              NevTab(
                text: 'add',
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.circlePlus,
                onTab: () => _onTap(2),
                selectedIcon: FontAwesomeIcons.circlePlus,
              ),
              NevTab(
                text: 'goal',
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.clock,
                onTab: () => _onTap(3),
                selectedIcon: FontAwesomeIcons.clock,
              ),
              NevTab(
                text: 'setting',
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.gear,
                onTab: () => _onTap(4),
                selectedIcon: FontAwesomeIcons.gear,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
