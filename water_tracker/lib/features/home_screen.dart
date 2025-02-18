import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/intake_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  DateTime now = DateTime.now();
  String date = DateFormat('MMMM d, yyyy').format(DateTime.now());

  bool isStop = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        if (context.read<IntakeProvider>().totalIntake >=
            context.read<IntakeProvider>().intakeGoal) {
          _controller.stop();

          if (mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("achieve!!"),
                content: Text("Congratulations! You did!"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
        }
        setState(() {}); // UI 강제 업데이트
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int intakeGoal = context.watch<IntakeProvider>().intakeGoal;
    int intakeReal = context.watch<IntakeProvider>().totalIntake;

    double outerConHeight = MediaQuery.of(context).size.height * 0.4 + 60;
    double actualIntakeHeight = outerConHeight * (intakeReal / intakeGoal);
    actualIntakeHeight = actualIntakeHeight.clamp(0, outerConHeight);

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
                  height: outerConHeight + 12,
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
                      borderRadius: BorderRadius.all(Radius.circular(22)),
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
                      "${context.watch<IntakeProvider>().calcul} %",
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
