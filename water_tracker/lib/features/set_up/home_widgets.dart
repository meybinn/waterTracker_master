import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/intake_provider.dart';

class HomeWidgets extends StatefulWidget {
  final String title;
  final String text;
  final String bool;
  const HomeWidgets({
    super.key,
    required this.title,
    required this.text,
    required this.bool,
  });

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  @override
  Widget build(BuildContext context) {
    final intakeProvider = context.read<IntakeProvider>();
    return Column(
      children: [
        Text(
          widget.title,
          style: GoogleFonts.righteous(
            fontSize: Sizes.size28,
            color: Color(0XFF7C7C7C),
          ),
        ),
        Text(
          widget.text,
          style: GoogleFonts.righteous(
            fontSize: Sizes.size16,
            color: Color(0XFF7C7C7C),
          ),
        ),
        Text(
          widget.bool,
          style: GoogleFonts.righteous(
            fontSize: Sizes.size14,
            color: Color(0XCC7C7C7C),
          ),
        ),
      ],
    );
  }
}
