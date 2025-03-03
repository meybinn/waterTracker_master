import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

class Setup extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? error;

  const Setup({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.scheherazadeNew(
            fontSize: Sizes.size22 + Sizes.size1,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gaps.v12,
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              errorText: error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hintText: hintText,
              hintStyle: GoogleFonts.scheherazadeNew(
                fontSize: Sizes.size16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }
}
