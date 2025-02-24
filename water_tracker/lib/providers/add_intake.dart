import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/intake_provider.dart';

// save해서 다른 전역 변수에 저장하는 기능 추가
// save 후 다시 들어와서 reset할 때의 변수 값
class AddIntake extends StatefulWidget {
  const AddIntake({
    super.key,
  });

  @override
  State<AddIntake> createState() => _AddIntakeState();
}

class _AddIntakeState extends State<AddIntake> {
  int initialTotalIntake = 0; // 여기 저장된 후의 intake 변수 넣기
  int intakeReal = 0;

  @override
  Widget build(BuildContext context) {
    int totalIntake = context.watch<IntakeProvider>().totalIntake; // 전역변수

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gaps.h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's",
                        style: GoogleFonts.righteous(
                          fontSize: Sizes.size32,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "Water Intake",
                        style: GoogleFonts.righteous(
                          fontSize: Sizes.size32,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gaps.v52,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 168,
                  height: 67,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
                    color: Color(0xFFd9d9d9),
                  ),
                  child: Text(
                    "${context.watch<IntakeProvider>().totalIntake} ml",
                    style: GoogleFonts.righteous(
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v36,
            LayoutBuilder(
              builder: (context, constraints) {
                final double screenWidth = constraints.maxWidth;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<IntakeProvider>().updateIntake(150);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.whiskeyGlass,
                              size: screenWidth * 0.25,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "A small cup",
                                style: GoogleFonts.righteous(
                                  fontSize: screenWidth * 0.05,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                "each tab added 150ml",
                                style: GoogleFonts.righteous(
                                  fontSize: screenWidth * 0.03,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gaps.h36,
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<IntakeProvider>().updateIntake(500);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.bottleWater,
                              size: screenWidth * 0.4,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "A bottle",
                                style: GoogleFonts.righteous(
                                  fontSize: screenWidth * 0.05,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                "each tab added 500ml",
                                style: GoogleFonts.righteous(
                                  fontSize: screenWidth * 0.03,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Gaps.v28,
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            Gaps.v28,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<IntakeProvider>().resetIntake();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0X75d9d9d9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    child: Text(
                      "reset",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.scheherazadeNew(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF828282),
                      ),
                    ),
                  ),
                ),
                Gaps.h48,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      intakeReal = 0;
                      // context.read<IntakeProvider>().updateIntake(totalIntake);
                    });

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Your water intake saved!"),
                          );
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0XFF4C89B2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    child: Text(
                      "save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.scheherazadeNew(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
