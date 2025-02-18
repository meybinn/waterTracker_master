import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Align(
          alignment: Alignment.centerLeft,
          child: 
            Text(
              "Log Out",
              style: GoogleFonts.scheherazadeNew(
                color: Colors.black,
                fontSize: Sizes.size22,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      content: Text(
        "Are you sure want to log out?",
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
              onPressed: () => Navigator.pop(context, 'Cancel'),
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
                'Cancel',
                style: GoogleFonts.scheherazadeNew(
                  fontSize: Sizes.size20,
                  color: Color(0XFF666666),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Log out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF4C89B2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Log out',
                style: GoogleFonts.scheherazadeNew(
                  fontSize: Sizes.size20,
                ),
                ),
            ),
          ],
        ),
      ],
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => DialogLogout(),
  );
}
