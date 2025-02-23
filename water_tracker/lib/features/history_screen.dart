import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  final Map<DateTime, List<String>> _intakeWater = {};

  void _updateDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;

      bool dataExist = _intakeWater.keys.any((date) =>
          date.year == newDate.year &&
          date.month == newDate.month &&
          date.day == newDate.day);

      if (!dataExist) {
        _intakeWater[newDate] = ['0 ml'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dailyRecords = _intakeWater.entries
        .where((entry) =>
            entry.key.year == _selectedDate.year &&
            entry.key.month == _selectedDate.month &&
            entry.key.day == _selectedDate.day)
        .map((entry) => entry.value.join('. '))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "History",
            style: GoogleFonts.righteous(
              color: Color(0XFF7C7C7C),
              fontSize: Sizes.size34,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                    onDateChanged: _updateDate,
                  ),
                ),
              ),
              Gaps.v10,
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _intakeWater.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  DateTime date = _intakeWater.keys.elementAt(index);
                  String formatDate = "${date.month}/${date.day}";
                  return ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.glassWater,
                        color: Color(0XFF7C7C7C),
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                      ),
                      child: Text(
                        formatDate,
                        style: GoogleFonts.righteous(
                            color: Color(0XFF7C7C7C), fontSize: Sizes.size20),
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(
                        right: 40,
                      ),
                      child: Text(
                        _intakeWater[date]!.join('. '),
                        style: GoogleFonts.righteous(
                            color: Color(0XFF7C7C7C), fontSize: Sizes.size20),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
