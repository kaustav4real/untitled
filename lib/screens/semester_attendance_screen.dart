import 'package:flutter/material.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_post.dart';
import 'package:untitled/helpers/date_functions.dart';

class SemesterScreen extends StatelessWidget {
  final String semester;
  final String subjectID;
  const SemesterScreen(
      {super.key, required this.semester, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '$semester Semester',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  'Attendance as of ${getTodayDate()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SemesterAttendanceLists(subjectID: subjectID),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
