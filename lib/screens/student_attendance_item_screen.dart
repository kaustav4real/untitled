import 'package:flutter/material.dart';
import 'package:untitled/components/student_attendance_screen/student_attendance_screen_item.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class StudentsAttendanceItemScreen extends StatelessWidget {
  final String rollNumber;
  final String name;
  final List < AttendanceDetailModel> attendanceList;
  const StudentsAttendanceItemScreen({
    super.key,
    required this.name,
    required this.rollNumber,
    required this.attendanceList,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            rollNumber,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              Text(
                'Attendance of $name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              StudentAttendanceLog(attendanceList: attendanceList),
            ],
          ),
        ),
      ),
    );
  }
}
