import 'package:flutter/material.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_functions.dart';
import 'package:untitled/models/subject_attendance_model.dart';
import 'package:untitled/screens/student_attendance_item_screen.dart';

class SemesterAttendanceListItem extends StatelessWidget {
  final String studentName;
  final String rollNumber;
  final List < AttendanceDetailModel> attendanceList;
  const SemesterAttendanceListItem(
      {super.key,
      required this.rollNumber,
      required this.studentName,
      required this.attendanceList,
      }
);

  @override
  Widget build(BuildContext context) {
    attendanceList.sort((a, b) => a.date.compareTo(b.date));
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
                context,
                StudentsAttendanceItemScreen(
                  rollNumber: rollNumber,
                  name: studentName, attendanceList: attendanceList,
                ),
            );
          },
          child: ListTile(
            title: Text(studentName),
            subtitle: Text(rollNumber),
            trailing: Text(
              '${calculateAttendance(attendanceList).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        const Divider(
          thickness: 0.3,
        )
      ],
    );
  }
}
