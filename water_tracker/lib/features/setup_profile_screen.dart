import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/features/set_up/setUp.dart';
import 'package:water_tracker/intake_provider.dart';
import 'package:water_tracker/providers/set_up_goal_screen.dart';
import 'package:water_tracker/setting/setting_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String gender = "";
  String age = "";
  String height = "";
  String weight = "";

  @override
  void initState() {
    super.initState();

    genderController.addListener(() {
      setState(() {
        gender = genderController.text;
      });
    });
    ageController.addListener(() {
      setState(() {
        age = ageController.text;
      });
    });
    heightController.addListener(() {
      setState(() {
        height = heightController.text;
      });
    });
    weightController.addListener(() {
      setState(() {
        weight = weightController.text;
      });
    });
  }

  @override
  void dispose() {
    genderController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();

    super.dispose();
  }

  void onNextTap() {
    if (gender.isNotEmpty &&
        age.isNotEmpty &&
        height.isNotEmpty &&
        weight.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetUpGoalScreen(),
        ),
      );
    }

    context.read<IntakeProvider>().setString(gender, age, weight, height);
  }

  String? isGenderValid() {
    if (gender.isEmpty) return null;
    if (gender != "Female" && gender != "Male") {
      return "ONLY Female or Male";
    }
    return null;
  }

  String? isAgeValid() {
    if (age.isEmpty) return null;
    if (RegExp(r'[a-zA-Z]').hasMatch(age)) {
      // 알파벳이 포함되어 있으면 "check again"
      return "check again";
    }
    // if (age.length == 1 || age.length >= 3) {
    //   return "check again";
    // }
    return null;
  }

  String? isHeightValid() {
    if (height.isEmpty) return null;
    if (RegExp(r'[a-zA-Z]').hasMatch(height)) {
      // 알파벳이 포함되어 있으면 "check again"
      return "check again";
    }
    return null;
  }

  String? isWeightValid() {
    if (weight.isEmpty) return null;
    if (RegExp(r'[a-zA-Z]').hasMatch(weight)) {
      // 알파벳이 포함되어 있으면 "check again"
      return "check again";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Set up your profile",
          style: GoogleFonts.sarabun(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.size52,
          right: 120,
          left: 120,
          bottom: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Setup(
              title: "Gender",
              hintText: "Female/Male",
              controller: genderController,
              error: isGenderValid(),
            ),
            Gaps.v24,
            Setup(
              title: "Age",
              hintText: "Enter your age",
              controller: ageController,
              error: isAgeValid(),
            ),
            Gaps.v24,
            Setup(
              title: "Height (cm)",
              hintText: "Enter your height in cm",
              controller: heightController,
              error: isHeightValid(),
            ),
            Gaps.v24,
            Setup(
              title: "Weight (kg)",
              hintText: "Enter your weight in kg",
              controller: weightController,
              error: isWeightValid(),
            ),
            Gaps.v24,
            GestureDetector(
              onTap: onNextTap,
              child: Container(
                padding: EdgeInsets.only(
                  top: Sizes.size6,
                  bottom: Sizes.size8,
                ),
                width: 660,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                ),
                child: Text(
                  "Next",
                  style: GoogleFonts.scheherazadeNew(
                    color: Color(0xFFE0E6FE),
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
