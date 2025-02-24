import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/intake_provider.dart';

class SaveGoalScreen extends StatefulWidget {
  const SaveGoalScreen({
    super.key,
  });

  @override
  State<SaveGoalScreen> createState() => _SaveGoalScreenState();
}

class _SaveGoalScreenState extends State<SaveGoalScreen> {
  // int intakeGoal = 2200;

  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int _interval = 1;
  double _sliderValue = 2000;

  void _increaseGoal() {
    setState(() {
      int newValue = context.watch<IntakeProvider>().intakeGoal + 10;
      context.watch<IntakeProvider>().updateGoal(newValue, _interval);
      _sliderValue = newValue.toDouble();
    });
  }

  void _decreaseGoal() {
    setState(() {
      int newValue = context.watch<IntakeProvider>().intakeGoal - 10;
      context.watch<IntakeProvider>().updateGoal(newValue, _interval);
      _sliderValue = newValue.toDouble();
    });
  }

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          isFromTime ? fromTime ?? TimeOfDay.now() : toTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFromTime) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    int intakeGoal = context.watch<IntakeProvider>().intakeGoal;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.15,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "You're daily intake goal is $intakeGoal ml",
                    style: GoogleFonts.hammersmithOne(
                      fontSize: Sizes.size22,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                ),
                Gaps.v12,
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Image.asset(
                    'assets/icons/calendar.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                Gaps.v8,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Stay refreshed! Aim for at least 2200 ml or set your own hydration goal.",
                    style: GoogleFonts.habibi(
                      fontSize: Sizes.size12 + Sizes.size1,
                      color: Color(0xFF7C7C7C),
                    ),
                    maxLines: 2,
                  ),
                ),
                Gaps.v16,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _decreaseGoal,
                      icon: FaIcon(
                        FontAwesomeIcons.circleMinus,
                        color: Color(0xFF4C89B2),
                        size: Sizes.size22,
                      ),
                    ),
                    Gaps.h5,
                    SizedBox(
                      width: screenWidth * 0.45,
                      child: Slider(
                          // value: _sliderValue,
                          value: intakeGoal.toDouble(),
                          min: 0,
                          max: 5000,
                          divisions: 50,
                          activeColor: Color(0xFF4C89B2),
                          inactiveColor: Colors.white,
                          onChanged: (double newValue) {
                            setState(() {
                              context
                                  .read<IntakeProvider>()
                                  .updateGoal(newValue.toInt(), _interval);
                            });
                          }),
                    ),
                    Gaps.h1,
                    IconButton(
                      onPressed: _increaseGoal,
                      icon: FaIcon(
                        FontAwesomeIcons.circlePlus,
                        color: Color(0xFF4C89B2),
                        size: Sizes.size22,
                      ),
                    ),
                  ],
                ),
                Gaps.v10,
                Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: 270,
                          height: 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0XFFDFDCDC),
                              width: 0.5,
                            ),
                          ),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "From Time",
                              labelStyle: GoogleFonts.scheherazadeNew(
                                color: Color(0XFF7C7C7C),
                                fontSize: Sizes.size20,
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.access_time,
                                  color: Color(0XFF7C7C7C),
                                  size: Sizes.size28,
                                ),
                                onPressed: () => _selectTime(context, true),
                              ),
                            ),
                            controller: TextEditingController(
                              text: fromTime != null
                                  ? fromTime!.format(context)
                                  : "",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Gaps.v20,
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: 270,
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0XFFDFDCDC),
                          width: 0.5,
                        ),
                      ),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "To Time",
                          labelStyle: GoogleFonts.scheherazadeNew(
                            color: Color(0XFF7C7C7C),
                            fontSize: Sizes.size20,
                          ),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.access_time,
                              color: Color(0XFF7C7C7C),
                              size: Sizes.size28,
                            ),
                            onPressed: () => _selectTime(context, false),
                          ),
                        ),
                        controller: TextEditingController(
                          text: toTime != null ? toTime!.format(context) : "",
                        ),
                      ),
                    );
                  },
                ),
                Gaps.v20,
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: 270,
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0XFFDFDCDC),
                          width: 0.5,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Interval (hour)",
                          labelStyle: GoogleFonts.scheherazadeNew(
                            color: Color(0XFF7C7C7C),
                            fontSize: Sizes.size20,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _interval = int.tryParse(value) ?? 1;
                          });
                        },
                      ),
                    );
                  },
                ),
                Gaps.v28,
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("your goal is modified"),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(130, 60),
                            backgroundColor: Color(0xFF4C89B2),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.scheherazadeNew(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size20,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(130, 60),
                            backgroundColor: Color(0xFFD9D9D9),
                          ),
                          child: Text(
                            "Don't save",
                            style: GoogleFonts.scheherazadeNew(
                              color: Color(0XFF828282),
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size20,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
