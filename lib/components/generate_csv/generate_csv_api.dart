import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../models/subject_attendance_model.dart';

Future<void> generateCSV(List<SubjectAttendanceModel> data) async {
  List<List<String>> csvData = [
    ["rollNumber", "name"]
  ];

  // Extract all unique dates with class numbers
  Set<String> headers = {};
  for (var subject in data) {
    for (var attendance in subject.attendance) {
      headers.add("${attendance.date}-class${attendance.classNumber}");
    }
  }

  // Convert Set to List and sort it
  List<String> headerList = headers.toList();
  headerList.sort();

  csvData[0].addAll(headerList);

  // Add student data rows
  for (var subject in data) {
    List<String> row = ["${subject.rollNumber.toString()}\t", subject.name]; // Enclose roll number in double quotes
    Map<String, String> attendanceMap = {
      for (var detail in subject.attendance)
        "${detail.date}-class${detail.classNumber}": detail.present ? "Present" : "Absent"
    };

    // Iterate over sorted headers
    for (var header in headerList) {
      row.add(attendanceMap[header] ?? "");
    }

    csvData.add(row);
  }

  String csv = const ListToCsvConverter().convert(csvData);

  final String tempDirectory = (await getTemporaryDirectory()).path;
  final String tempFileName = DateTime.now().toString();
  final path = '$tempDirectory/attendance_report_$tempFileName.csv';
  final File file = File(path);

  await file.writeAsString(csv);

  // Open the temporary file
  await OpenFile.open(path);
}
