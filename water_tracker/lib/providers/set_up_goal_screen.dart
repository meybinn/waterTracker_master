import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/intake_provider.dart';
import 'package:water_tracker/services/database_helper.dart';

class SetUpGoalScreen extends StatefulWidget {
  const SetUpGoalScreen({
    super.key,
  });

  @override
  State<SetUpGoalScreen> createState() => _SetUpGoalScreenState();
}

class _SetUpGoalScreenState extends State<SetUpGoalScreen> {
  int intakeGoal = 2200;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int _interval = 1;
  double _sliderValue = 2000;
  String userId = "riha";

  void _increaseGoal() {
    setState(() {
      intakeGoal += 10;
      _sliderValue = intakeGoal.toDouble();
    });
  }

  void _decreaseGoal() {
    setState(() {
      if (intakeGoal > 10) {
        intakeGoal -= 10;
        _sliderValue = intakeGoal.toDouble();
      }
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

  void _onNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(tab: 'home'),
      ),
    );
  }

  Future<void> _saveGoal() async {
    if(userId.isNotEmpty && fromTime != null && toTime != null && _interval > 0){

      try{
      await DatabaseHelper.instance.insertOrUpdateGoal(
        userId, 
        intakeGoal, 
        fromTime!, 
        toTime!, 
        _interval,
        );

        final intakeProvider = Provider.of<IntakeProvider>(context, listen: false);
        intakeProvider.updateGoal(intakeGoal, _interval);

        _onNext();
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed save goal."),),);
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the parts correctly!"),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
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
            Gaps.v16,
            Icon(
              Icons.calendar_today_rounded,
              color: Colors.white,
              size: Sizes.size80,
            ),
            Gaps.v20,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
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
                  width: 180,
                  child: Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      activeColor: Color(0xFF4C89B2),
                      inactiveColor: Colors.white,
                      onChanged: (double newValue) {
                        setState(() {
                          _sliderValue = newValue;
                          intakeGoal = _sliderValue.toInt();
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
            Gaps.v20,
            Column(
              children: [
                Container(
                  width: 225,
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
                        fontSize: Sizes.size16,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.access_time,
                          color: Color(0XFF7C7C7C),
                          size: Sizes.size24,
                        ),
                        onPressed: () => _selectTime(context, true),
                      ),
                    ),
                    controller: TextEditingController(
                      text: fromTime != null ? fromTime!.format(context) : "",
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v16,
            Container(
              width: 225,
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
                    fontSize: Sizes.size16,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.access_time,
                      color: Color(0XFF7C7C7C),
                      size: Sizes.size24,
                    ),
                    onPressed: () => _selectTime(context, false),
                  ),
                ),
                controller: TextEditingController(
                  text: toTime != null ? toTime!.format(context) : "",
                ),
              ),
            ),
            Gaps.v16,
            Container(
              width: 225,
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
                    fontSize: Sizes.size16,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _interval = int.tryParse(value) ?? 1;
                  });
                },
              ),
            ),
            Gaps.v36,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 55),
                    backgroundColor: Color(0xFFD9D9D9),
                  ),
                  child: Text(
                    "Back",
                    style: GoogleFonts.scheherazadeNew(
                      color: Color(0XFF828282),
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveGoal,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 55),
                    backgroundColor: Color(0xFF4C89B2),
                  ),
                  child: Text(
                    "Next",
                    style: GoogleFonts.scheherazadeNew(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}