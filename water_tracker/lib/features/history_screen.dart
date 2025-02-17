import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedDate = DateTime.now();

  final Map<DateTime, List<String>> _intakeWater = {
    DateTime(2025, 2, 15): ['1500 ml'],
    DateTime(2025, 2, 16): ['3000 ml'],
  };

  @override
  Widget build(BuildContext context) {
    List<String> dailyRecords = _intakeWater[_selectedDate] ?? [];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "History",
          style: GoogleFonts.righteous(
            color: Color(0XFF7C7C7C),
            fontSize: Sizes.size36,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CalendarDatePicker(
                  initialDate: _selectedDate,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2030),
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ),
            Gaps.v20,
            dailyRecords.isEmpty
                ? Text(
                    "No records for this day",
                    style: GoogleFonts.righteous(
                      color: Color(0XFF7C7C7C),
                      fontSize: Sizes.size20,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dailyRecords.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dailyRecords[index]),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
