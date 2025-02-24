import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

class Signup extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const Signup(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.scheherazadeNew(
            fontSize: Sizes.size20,
          ),
        ),
        Gaps.v10,
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true, // 배경색 활성화
            fillColor: Colors.white,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            hintStyle: GoogleFonts.scheherazadeNew(
              fontSize: Sizes.size16,
              color: Colors.grey,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              gapPadding: Sizes.size2,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              gapPadding: Sizes.size2,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDFDCDC), width: 2),
              gapPadding: Sizes.size2,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              gapPadding: Sizes.size2,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              gapPadding: Sizes.size2,
            ),
          ),
        ),
      ],
    );
  }
}
