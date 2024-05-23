import 'package:flutter/material.dart';
import 'package:untitled/components/generate_pdf/pdf_attendance_api.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class DownloadAttendancePdf extends StatelessWidget {
  final List<SubjectAttendanceModel> data;
  const DownloadAttendancePdf({super.key, required this.data});

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
            const Text(
              'PDF',
              style: TextStyle(
                color: Color(0XFFf3f6ed),
              ),
            ),
            Icon(Icons.download, color: Colors.white,size: width*0.06,)
          ],
        )
      ),
    );
  }
}
