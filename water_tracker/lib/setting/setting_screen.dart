import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/setting/dialog_logout.dart';
import 'package:water_tracker/intake_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotificationEnabled = false;
  bool isFull = false;

  void _logOutTap() {
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment(0.0, -0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.v20,
            Icon(
              Icons.account_circle_outlined,
              size: 120,
              color: Color(0XCC7C7C7C),
            ),
            Gaps.v5,
            Text(
              "Username",
              style: GoogleFonts.scheherazadeNew(
                color: Color(0XFF7C7C7C),
                fontSize: Sizes.size26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v28,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      context.read<IntakeProvider>().gender,
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF7C7C7C),
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "gender",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF9B9CA4),
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.read<IntakeProvider>().age,
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF7C7C7C),
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "age",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF9B9CA4),
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.v24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      context.read<IntakeProvider>().height,
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF7C7C7C),
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "height (cm)",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF9B9CA4),
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.read<IntakeProvider>().weight,
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF7C7C7C),
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "weight (kg)",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF9B9CA4),
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.v24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "${context.read<IntakeProvider>().intakeGoal}",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF7C7C7C),
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "intake goal (ml)",
                      style: GoogleFonts.scheherazadeNew(
                        color: Color(0XFF9B9CA4),
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.v80,
            Divider(
              color: Color(0XFF7C7C7C),
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Allow notification",
                  style: GoogleFonts.scheherazadeNew(
                    color: Color(0XFF7C7C7C),
                    fontSize: Sizes.size28 + Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                  },
                  activeColor: Color(0XFF4C89B2),
                ),
              ],
            ),
            Gaps.v28,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => showLogoutDialog(context),
                  child: Text(
                    "Log out",
                    style: GoogleFonts.scheherazadeNew(
                      color: Color(0XFFEB6F6F),
                      fontSize: Sizes.size34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "really want to log out?",
                  style: GoogleFonts.scheherazadeNew(
                    color: Color(0XFF9B9CA4),
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.bold,
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
