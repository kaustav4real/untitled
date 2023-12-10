import 'package:flutter/material.dart';

class SemesterAttendanceListItem extends StatelessWidget {
  final String studentName;
  final String rollNumber;
  final String attendance;
  const SemesterAttendanceListItem({super.key, required this.rollNumber, required this.studentName, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(studentName),
          subtitle:Text(rollNumber),
          trailing: Text('$attendance%', style: Theme.of(context).textTheme.labelMedium,),
        ),
        Divider(thickness: 0.3,)
      ],
    );
  }
}
