import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/sizes.dart';

class DialogGoalAchieved extends StatelessWidget {
  const DialogGoalAchieved({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Goal Achieved!",
          style: GoogleFonts.scheherazadeNew(
            color: Colors.black,
            fontSize: Sizes.size22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Text(
        "You have reached your daily water intake goal!\nKeep staying hydrated!",
        style: GoogleFonts.scheherazadeNew(
          color: Colors.black,
          fontSize: Sizes.size20,
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFD9D9D9),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.scheherazadeNew(
                  fontSize: Sizes.size20,
                  color: Color(0XFF666666),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<bool> showGoalAchievedDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => DialogGoalAchieved(),
      ) ??
      false;
}
