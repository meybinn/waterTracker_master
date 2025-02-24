import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/set_up/home_widgets.dart';
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
  bool noti = false;

  void _addwater(int intakeAmount) async {
    final intakeProvider = context.read<IntakeProvider>();
    intakeProvider.updateIntake(intakeAmount); //intake total 업데이트
    intakeProvider.addIntakeHistory(intakeAmount); //history에서 intake 기록
  }

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

        if (context.read<IntakeProvider>().isNotification) {
          FlutterLocalNotification.showNotification();
        }

        setState(() {
          noti = true;
        });

        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              noti = false;
            });
          }
        });

        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('WATER REMINDER!!'),
              content: Text('Time to drink water!! Stay hydrated💧'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 기존 interval로 다시 카운트다운 시작
                    _startCoundown();
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        }

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
    final intakeProvider = context.read<IntakeProvider>();

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
                          borderRadius: BorderRadius.all(
                            Radius.circular(22),
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
                  HomeWidgets(
                    title: "${context.watch<IntakeProvider>().calcul} %",
                    text: "Progress",
                    bool: (intakeProvider.totalIntake >=
                            intakeProvider.intakeGoal)
                        ? "Achieve!"
                        : "Incomplete",
                  ),
                  Gaps.h32,
                  HomeWidgets(
                    title: formatCountdown,
                    text: "Reminder",
                    bool: context.read<IntakeProvider>().isNotification
                        ? "on"
                        : "off",
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
