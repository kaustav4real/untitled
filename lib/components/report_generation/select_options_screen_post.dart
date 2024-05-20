import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/components/report_generation/select_options_screen_item.dart';
import 'package:untitled/helpers/date_functions.dart';

class SelectReportGenerationOption extends StatefulWidget {
  final String semester;
  final String subjectID;
  final String subjectName;
  const SelectReportGenerationOption(
      {super.key, required this.semester, required this.subjectID, required this.subjectName});

  @override
  State<SelectReportGenerationOption> createState() =>
      _SelectReportGenerationOptionState();
}

class _SelectReportGenerationOptionState
    extends State<SelectReportGenerationOption> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '${widget.semester} Semester',
            style: GoogleFonts.openSans(fontSize: width * 0.046),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  'Attendance as of ${getTodayDate()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SemesterAttendanceListsItem(subjectID: widget.subjectID, subjectName: widget.subjectName,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
