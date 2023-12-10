import 'package:flutter/material.dart';
import 'package:untitled/helpers/date_functions.dart';

class Attendance {
  DateTime date;
  bool present;
  Attendance({
    required this.date,
    required this.present,
  });
}

List<Attendance> attendanceList = [
  Attendance(date: DateTime(2023, 12, 1), present: true),
  Attendance(date: DateTime(2023, 12, 2), present: false),
  Attendance(date: DateTime(2023, 12, 3), present: true),
  Attendance(date: DateTime(2023, 12, 4), present: false),
  Attendance(date: DateTime(2023, 12, 5), present: true),
  Attendance(date: DateTime(2023, 12, 6), present: false),
  Attendance(date: DateTime(2023, 12, 7), present: true),
  Attendance(date: DateTime(2023, 12, 8), present: false),
  Attendance(date: DateTime(2023, 12, 9), present: true),
  Attendance(date: DateTime(2023, 12, 10), present: false),
];

class StudentAttendanceLog extends StatelessWidget {
  const StudentAttendanceLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: attendanceList
            .map(
              (e) => Column(
                children: [
                  ListTile(
                    title: Text(formatDateTime(e.date)),
                    subtitle: Text(getDayFromDate(e.date)),
                    trailing: e.present
                        ? const Icon(Icons.check)
                        : const Icon(Icons.cancel),
                  ),
                  const Divider(thickness: 0.3),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
