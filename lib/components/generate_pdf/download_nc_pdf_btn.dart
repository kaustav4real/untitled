import 'package:flutter/material.dart';
import 'package:untitled/components/generate_pdf/pdf_nc_attendance_api.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class DownloadNCListPdf extends StatelessWidget {
  final List<SubjectAttendanceModel> data;
  final String message;
  final String subjectName;
  final String subjectID;
  const DownloadNCListPdf({super.key, required this.data, required this.message, required this.subjectName, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: TextButton(
          onPressed: () async {
            await PdfAttendanceApiForNc.generate(data, message, subjectName, subjectID);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PDF',
                style: TextStyle(
                  color: Color(0XFFf3f6ed),
                ),
              ),
              Icon(
                Icons.download,
                color: Colors.white,
                size: width * 0.06,
              )
            ],
          ),
      ),
    );
  }
}
