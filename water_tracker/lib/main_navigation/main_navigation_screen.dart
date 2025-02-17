import 'package:flutter/material.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF7C7C7C),
          items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.water_drop),),
          ],
          ),
      ),
    );
  }
}