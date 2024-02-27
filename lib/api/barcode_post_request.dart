import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/constants.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/models/user_model.dart';

sendBarcodeDataToServer(String rollNumber) {
  UserLocalInfo userLocalInfo = getUserInfo();
  try {
    Map<String, String> data = {'rollNumber': rollNumber};
    http.post(
      Uri.parse(apiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userLocalInfo.token}',
      },
      body: jsonEncode(data),
    );
  } catch (error) {
    return false;
  }
}
