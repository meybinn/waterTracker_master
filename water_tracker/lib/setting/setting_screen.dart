import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/start_screen.dart';
import 'package:water_tracker/setting/dialog_logout.dart';
import 'package:water_tracker/intake_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotificationEnabled = false; // 초기값 설정

  // 로그아웃 기능
  void _logOutTap() {
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => const StartScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final intakeProvider = context.watch<IntakeProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment(0.0, -0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.v20,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 120,
                  color: const Color(0XCC7C7C7C),
                ),
              ),
              Gaps.v1,
              Text(
                intakeProvider.username ?? "Username", // 값이 없으면 기본값
                style: GoogleFonts.scheherazadeNew(
                  color: const Color(0XFF7C7C7C),
                  fontSize: Sizes.size26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn(intakeProvider.gender ?? "N/A", "gender"),
                  _buildInfoColumn(intakeProvider.age ?? "N/A", "age"),
                ],
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn(
                      intakeProvider.height ?? "N/A", "height (cm)"),
                  _buildInfoColumn(
                      intakeProvider.weight ?? "N/A", "weight (kg)"),
                ],
              ),
              Gaps.v20,
              _buildInfoColumn(
                "${intakeProvider.intakeGoal ?? 0}",
                "intake goal (ml)",
                isCentered: true,
              ),
              Gaps.v28,
              const Divider(
                color: Color(0XFF7C7C7C),
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              Gaps.v14,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Allow notification",
                    style: GoogleFonts.scheherazadeNew(
                      color: const Color(0XFF7C7C7C),
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: context.read<IntakeProvider>().isNotification,
                      onChanged: (bool value) {
                        // 알람 킬 때
                        if (!context.read<IntakeProvider>().isNotification) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("⚠️ALERT⚠️"),
                              content: Text(
                                  "Are you sure you want to turn on the alarm?"),
                              actions: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.of(context).pop(),
                                    context
                                        .read<IntakeProvider>()
                                        .setNotification(value),
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Color(0XFF4C89B2)),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.of(context).pop(),
                                        },
                                    style: TextButton.styleFrom(),
                                    child: Text(
                                      "NO",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                              ],
                            ),
                          );
                          // 알람 끌 때
                        } else {
                          context.read<IntakeProvider>().setNotification(value);
                        }
                      },
                      activeColor: const Color(0XFF4C89B2),
                    ),
                  ),
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => showLogoutDialog(context),
                child: Text(
                  "Log out",
                  style: GoogleFonts.scheherazadeNew(
                    color: const Color(0XFFEB6F6F),
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "really want to log out?",
                    style: GoogleFonts.scheherazadeNew(
                      color: const Color(0XFF9B9CA4),
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 중복되는 정보를 하나의 메서드로 묶음
  Widget _buildInfoColumn(String value, String label,
      {bool isCentered = false}) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.scheherazadeNew(
            color: const Color(0XFF7C7C7C),
            fontSize: Sizes.size28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.scheherazadeNew(
            color: const Color(0XFF9B9CA4),
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
