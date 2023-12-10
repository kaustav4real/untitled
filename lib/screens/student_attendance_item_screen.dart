import 'package:flutter/material.dart';
import 'package:untitled/components/student_attendance_screen/student_attendance_screen_item.dart';
import 'package:untitled/helpers/date_functions.dart';

class StudentsAttendanceItemScreen extends StatelessWidget {
  final String rollNumber;
  final String name;
  const StudentsAttendanceItemScreen({
    super.key,
    required this.name,
    required this.rollNumber,
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
              const StudentAttendanceLog(),
            ],
          ),
        ),
      ),
    );
  }
}
