import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/constants.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/models/assigned_class_models.dart';
import 'package:untitled/models/user_model.dart';

const getSubjectsUrl = '$apiBaseUrl/teachers/details';

Future<AllClassScheduleDTO> getSubjectsAssigned() async {
  UserLocalInfo info = getUserInfo();
  try {
    final response = await http.get(
      Uri.parse('$getSubjectsUrl/${info.userName}'),
      headers: {
        'Authorization':
            'Bearer ${info.token}', // Include the bearer token here
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      List<dynamic> ownSubjectsJson = jsonResponse['ownSubjects'];
      List<dynamic> assignedSubjectsJson = jsonResponse['assignedSubjects'];

      List<ClassSchedule> ownSubjects = ownSubjectsJson.map((json) => ClassSchedule.fromJson(json)).toList();
      List<ClassSchedule> assignedSubjects = assignedSubjectsJson.map((json) => ClassSchedule.fromJson(json)).toList();

      return AllClassScheduleDTO(
          ownSubjects: ownSubjects, assignedSubjects: assignedSubjects);
    } else {
      return AllClassScheduleDTO(ownSubjects: [], assignedSubjects: []);
    }
  } catch (error) {
    return AllClassScheduleDTO(ownSubjects: [], assignedSubjects: []);
  }
}
