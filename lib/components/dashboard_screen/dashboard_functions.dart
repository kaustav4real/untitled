import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/constants.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/models/assigned_class_models.dart';
import 'package:untitled/models/user_model.dart';

const getSubjectsUrl = '$apiBaseUrl/teachers/details';

Future<List<ClassSchedule>> getSubjectsAssigned() async {
  UserLocalInfo info = getUserInfo();
  try {
    final response = await http.get(
      Uri.parse('$getSubjectsUrl/${info.userName}'),
      headers: {
        'Authorization': 'Bearer ${info.token}', // Include the bearer token here
      },
    );
    if (response.statusCode == 200) {
      // Parse JSON response
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      List<ClassSchedule> classSchedules = jsonResponse
          .map((map) => ClassSchedule.fromJson(map))
          .toList();

      return classSchedules;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    // Handle exceptions that might occur during the HTTP request
    print('Error fetching data: $error');
    return [];
  }
}

