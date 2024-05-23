import 'package:flutter/material.dart';
import 'package:untitled/components/generate_csv/generate_csv_api.dart';

import '../../models/subject_attendance_model.dart';


class GenerateCSV extends StatelessWidget {
  final List<SubjectAttendanceModel> data;
  const GenerateCSV({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async{
          await generateCSV(data);
        },
        child: Text('Generate CSV'),
    );
  }
}
