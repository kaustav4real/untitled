import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:untitled/components/generate_pdf/pdf_api.dart';
import 'package:untitled/helpers/date_functions.dart';

import '../../models/subject_attendance_model.dart';

class PdfAttendanceApiForNc {
  static Future<File> generate(
    List<SubjectAttendanceModel> subjectAttendances,
    final String message,
    final String subjectName,
    final String subjectID,
  ) async {
    try {
      final pdf = pw.Document();
      final bytes = await rootBundle.load('assets/college_logo.png');
      final image = pw.MemoryImage(
        bytes.buffer.asUint8List(),
      );
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            final headers = ['S/N', 'Name', 'Roll number', 'Percentage'];
            final data = subjectAttendances.asMap().entries.map(((entry) {
              int index = entry.key + 1;
              var detail = entry.value;
              return [
                index.toString(),
                detail.name,
                detail.rollNumber,
                calculateAttendancePercentage(detail.attendance)
                    .toStringAsFixed(2)
              ];
            })).toList();

            return [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(image, width: 60, height: 60),
                  pw.SizedBox(height: 5),
                  pw.Divider(),
                  pw.SizedBox(height: 5),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('Jorhat Engineering College'),
                        pw.SizedBox(height: 5),
                        pw.Text('Department of Computer Science & Engineering'),
                        pw.SizedBox(height: 5),
                        pw.Text(subjectName),
                        pw.SizedBox(height: 5),
                        pw.Text('( $subjectID )'),
                        pw.SizedBox(height: 30),
                        pw.Text('$message as of ${getTodayDate()}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ])
                ],
              ),
              pw.SizedBox(height: 30),
              pw.TableHelper.fromTextArray(
                headers: headers,
                data: data,
                border: pw.TableBorder.all(color: PdfColors.black),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerRight
                },
              ),
              pw.Expanded(child: pw.SizedBox.shrink()),
              buildFooter()
            ];
          },
        ),
      );

      final file =
          await PdfApi.saveDocument(name: 'attendance_report.pdf', pdf: pdf);
      await PdfApi.openFile(file);
      return file;
    } catch (e) {
      return Future.error('PDF generation failed');
    }
  }

  static double calculateAttendancePercentage(
      List<AttendanceDetailModel> attendance) {
    if (attendance.isEmpty) return 0.0;
    final presentDays = attendance.where((detail) => detail.present).length;
    return (presentDays / attendance.length) * 100;
  }

  static pw.Widget buildFooter() => pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Subject Teacher\nSignature', textAlign: pw.TextAlign.center),
          pw.Text(
            'Head Of Department\nSignature',
            textAlign: pw.TextAlign.center,
          ),
        ],
      );
}
