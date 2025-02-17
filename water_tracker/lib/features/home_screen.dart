import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final int intakeGoal = 2200;
  final double intakeReal = 1500;

  DateTime now = DateTime.now();
  String date = DateFormat('MMMM d, yyyy').format(DateTime.now());

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
    double outerConHeight = MediaQuery.of(context).size.height * 0.4 + 60;
    double actualIntakeHeight = outerConHeight * (intakeReal / intakeGoal);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      date,
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
              "$intakeGoal ml",
              style: GoogleFonts.righteous(
                fontSize: Sizes.size28,
                color: Color(0XFF7C7C7C),
              ),
            ),
            Gaps.v2,
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 220,
                  height: outerConHeight,
                  decoration: BoxDecoration(
                    color: Color(0x507C7C7C),
                    border: Border.all(
                      width: 6,
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(23),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 207,
                    height: actualIntakeHeight,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                  ),
                ),
                Text(
                  "$intakeReal ml",
                  style: GoogleFonts.righteous(
                    fontSize: Sizes.size24,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            Gaps.v28,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "${(intakeReal / intakeGoal * 100).floor()}%",
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
                Gaps.h32,
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
