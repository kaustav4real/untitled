import 'package:flutter/material.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/screens/student_attendance_item_screen.dart';

class SemesterAttendanceListItem extends StatelessWidget {
  final String studentName;
  final String rollNumber;
  final String attendance;
  const SemesterAttendanceListItem(
      {super.key,
      required this.rollNumber,
      required this.studentName,
      required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
                context,
                StudentsAttendanceItemScreen(
                  rollNumber: rollNumber,
                  name: studentName,
                ),
            );
          },
          child: ListTile(
            title: Text(studentName),
            subtitle: Text(rollNumber),
            trailing: Text(
              '$attendance%',
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
