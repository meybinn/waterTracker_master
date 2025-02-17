import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v44,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 120,
                  color: Color(0XFF7C7C7C),
                ),
                Gaps.h10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Have a good day!",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size32,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                    Gaps.v4,
                    Text(
                      "March 13, 2025",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size20,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.v20,
            Text(
              "2200ml",
              style: GoogleFonts.righteous(
                fontSize: Sizes.size28,
                color: Color(0XFF7C7C7C),
              ),
            ),
            Gaps.v2,
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Icon(
                  Icons.local_drink,
                  size: 200,
                  color: Colors.grey.shade300,
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 5),
                  curve: Curves.easeInOut,
                  height: 150 * _animation.value,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ],
            ),
            Gaps.v36,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "50%",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size28,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                    Text(
                      "Progress",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size16,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "0:28:42",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size28,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                    Text(
                      "Reminder",
                      style: GoogleFonts.righteous(
                        fontSize: Sizes.size16,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
