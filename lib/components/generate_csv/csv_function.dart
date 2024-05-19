import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/models/subject_attendance_model.dart';

Future<void> generateCSV(List<SubjectAttendanceModel> data) async {
  List<List<String>> csvData = [
    ["rollNumber", "name"]
  ];

  // Extract all unique dates with class numbers
  Set<String> headers = {};
  for (var subject in data) {
    for (var attendance in subject.attendance) {
      headers.add("${attendance.date}, class${attendance.classNumber}");
    }
  }

  List<String> headerList = headers.toList();
  csvData[0].addAll(headerList);

  // Add student data rows
  for (var subject in data) {
    List<String> row = [subject.rollNumber, subject.name];
    Map<String, String> attendanceMap = {
      for (var detail in subject.attendance)
        "${detail.date}, class${detail.classNumber}": detail.present ? "present" : "absent"
    };

    for (var header in headerList) {
      row.add(attendanceMap[header] ?? "absent");
    }

    csvData.add(row);
  }

  String csv = const ListToCsvConverter().convert(csvData);

  final String directory = (await getApplicationDocumentsDirectory()).path;
  final path = '$directory/attendance_report.csv';
  final File file = File(path);

  await file.writeAsString(csv);
  print("CSV report generated at: $path");
}
