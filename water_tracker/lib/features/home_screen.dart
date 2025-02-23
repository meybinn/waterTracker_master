import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/intake_provider.dart';
import 'package:water_tracker/notification/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late String userId;

  late AnimationController _controller;
  late Animation<double> _animation;

  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

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
        if (mounted) setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final intakeProvider = context.read<IntakeProvider>();

      if (intakeProvider.totalIntake >= intakeProvider.intakeGoal) {
        _controller.stop();
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Achieve!"),
              content: Text("Congratulations! You did it!"),
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
      _startCoundown();
    });
  }

  void _startCoundown() {
    _timer?.cancel(); // 기존 Timer 취소

    final intakeProvider = context.read<IntakeProvider>();
    int interval = intakeProvider.interval;

    DateTime now = DateTime.now();
    DateTime nextReminder = now.add(Duration(hours: interval));

    _timeRemaining = nextReminder.difference(now);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining -= Duration(seconds: 1);
        });

        if (_timeRemaining.inMinutes == 2 && _timeRemaining.inSeconds == 0) {
          FlutterLocalNotification.showNotification();
        }
      } else {
        timer.cancel();
        _startCoundown();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int intakeGoal = context.watch<IntakeProvider>().intakeGoal;
    int intakeReal = context.watch<IntakeProvider>().totalIntake;

    double outerConHeight = MediaQuery.of(context).size.height * 0.4 + 60;
    if (outerConHeight <= 0) {
      outerConHeight = 100;
    }

    double actualIntakeHeight = outerConHeight * (intakeReal / intakeGoal);
    actualIntakeHeight = actualIntakeHeight.isNaN || actualIntakeHeight < 0
        ? 0
        : actualIntakeHeight;
    actualIntakeHeight = actualIntakeHeight.clamp(0, outerConHeight);

    String formatCountdown =
        "${_timeRemaining.inHours.toString().padLeft(2, '0')}:" //카운트다운 시간 형식
        "${(_timeRemaining.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(_timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v36,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                    color: Color(0XFF7C7C7C),
                  ),
                  Gaps.h5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Have a good day!",
                        style: GoogleFonts.righteous(
                          fontSize: Sizes.size22,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF7C7C7C),
                        ),
                      ),
                      Gaps.v4,
                      Text(
                        date,
                        style: GoogleFonts.righteous(
                          fontSize: Sizes.size18,
                          color: Color(0XFF7C7C7C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v28,
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
                    width: 190,
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
                  if (intakeReal > 0)
                    Positioned(
                      bottom: 6,
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 180,
                        height: actualIntakeHeight - 10,
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
                        formatCountdown,
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
      ),
    );
  }
}
