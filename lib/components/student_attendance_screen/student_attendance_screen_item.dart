import 'package:flutter/material.dart';
import 'package:untitled/helpers/date_functions.dart';
import 'package:untitled/models/subject_attendance_model.dart';


class StudentAttendanceLog extends StatelessWidget {
  final List<AttendanceDetailModel > attendanceList;
  const StudentAttendanceLog({super.key, required this.attendanceList});

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
                    leading:Text('Class ${e.classNumber}'),
                    title: Text(formatDateTime(e.date)),
                    subtitle: Text(getDayFromDate(e.date)),
                    trailing: e.present
                        ? const Icon(Icons.check)
                        : const Icon(Icons.cancel),
                  ),
                   const Divider(thickness:0.5),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
