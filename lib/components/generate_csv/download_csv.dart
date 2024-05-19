import 'package:flutter/material.dart';
import 'package:untitled/components/generate_csv/csv_function.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class DownloadCSV extends StatelessWidget {
  final List<SubjectAttendanceModel> data;
  const DownloadCSV({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await generateCSV(data);
        },
        child: const Text('Download CSV'));
  }
}
