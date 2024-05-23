import 'package:flutter/material.dart';
import 'package:untitled/components/generate_pdf/pdf_attendance_api.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class DownloadAttendancePdf extends StatelessWidget {
  final List<SubjectAttendanceModel> data;
  final String label;
  const DownloadAttendancePdf({super.key, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:  Colors.blue,
      ),
      child: TextButton(
        onPressed: () async {
             await PdfAttendanceApi.generate(data);
          },
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${label}PDF',
              style: TextStyle(
                color: const Color(0XFFf3f6ed),
                fontSize: width*0.032,
              ),
            ),
            Icon(Icons.download, color: Colors.white,size: width*0.06,)
          ],
        )
      ),
    );
  }
}
