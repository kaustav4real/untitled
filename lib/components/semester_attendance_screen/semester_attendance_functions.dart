import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/constants.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/models/subject_attendance_model.dart';
import 'package:untitled/models/user_model.dart';

const getSubjectsUrl = '$apiBaseUrl/attendance/details';

Future<List<SubjectAttendanceModel>> getSemesterAttendance(String subjectID) async {
  UserLocalInfo info = getUserInfo();
  try {
    final response = await http.get(
      Uri.parse('$getSubjectsUrl/$subjectID'),
      headers: {
        'Authorization': 'Bearer ${info.token}', // Include the bearer token here
      },
    );
    if (response.statusCode == 200) {
      // Parse JSON response
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      List<SubjectAttendanceModel> attendanceList = jsonResponse
          .map((subjectData) => SubjectAttendanceModel.fromJson(subjectData))
          .toList();

      return attendanceList;
    } else {
      // If the request was not successful, handle the error accordingly
      print('Request failed with status: ${response.statusCode}');
      return []; // or throw an exception
    }
  } catch (error) {
    // Handle exceptions that might occur during the HTTP request
    print('Error fetching data: $error');
    return []; // or throw an exception
  }
}

double calculateAttendance(List<AttendanceDetailModel> attendanceList) {
  if (attendanceList.isEmpty) {
    return 0.0; // Return 0 if the attendance list is empty
  }

  int presentCount = 0;

  for (var detail in attendanceList) {
    if (detail.present) {
      presentCount++;
    }
  }

  // Calculate percentage attendance
  double attendancePercentage = (presentCount / attendanceList.length) * 100;
  return attendancePercentage;
}
