import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/components/global/custom_snackbar.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/helpers/date_functions.dart';
import 'package:untitled/models/data_received_for_assigning_proxy_teacher_model.dart';

import '../database/user_model_db__functions.dart';
import '../models/user_model.dart';

class AssignProxyScreen extends StatefulWidget {
  const AssignProxyScreen({super.key});

  @override
  State<AssignProxyScreen> createState() => _AssignProxyScreenState();
}

class _AssignProxyScreenState extends State<AssignProxyScreen> {
  UserLocalInfo userLocalInfo = getUserInfo();
  bool isLoading = true;
  late TextEditingController _dateOfBirthController;

  List<SubjectModelForProxy> subjects = [];
  List<TeacherModelForProxy> teachers = [];

  String? subjectID;
  int? teacherID;
  String? subjectName;
  String? teacherName;

  handleErrorMessages(String message) {
    showCustomSnackBar(context, message);
  }

  getData() async {
    final String getTeacherAndSubjectInformationUForProxyUrl =
        '$apiBaseUrl/departments/assignProxy/getDetails/${userLocalInfo.userName}';
    final result = await http
        .get(Uri.parse(getTeacherAndSubjectInformationUForProxyUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userLocalInfo.token}',
    });

    if (result.statusCode == 200) {
      final body = jsonDecode(result.body);
      setState(() {
        teachers = (body['teachers'] as List)
            .map((e) => TeacherModelForProxy.fromJson(e))
            .toList();

        subjects = (body['subjects'] as List)
            .map((e) => SubjectModelForProxy.fromJson(e))
            .toList();

        isLoading = false;
      });
    }
  }

  Future<DateTime?> showCustomDatePicker(BuildContext context) async {
    return await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            canvasColor: Colors.red,
            primaryColor: Colors.red,
            textTheme: const TextTheme(
              labelSmall: TextStyle(fontSize: 16),
              labelLarge: TextStyle(fontSize: 18),
              headlineSmall: TextStyle(fontSize: 16),
              titleLarge: TextStyle(fontSize: 16),
              bodyLarge: TextStyle(fontSize: 16),
              titleMedium: TextStyle(fontSize: 16),
              titleSmall: TextStyle(fontSize: 16),
              bodySmall: TextStyle(fontSize: 16),
            ),
          ),
          child: DatePickerDialog(
            initialDate: DateTime.now(),
            firstDate: DateTime(1930),
            lastDate: DateTime.now().add(const Duration(days: 7)),
            // Customize other properties if needed
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateOfBirthController.text = getDateInYYYYMMDDFromArgument(value);
        });
      }
      return null;
    });
  }


  handleSuccessfulProxyAssignment(String message){
    showCustomSnackBar(context, message);
  }

  submitData() async {
    if (subjectName == null || teacherID == null) {
      handleErrorMessages('Please select all the fields');
      return;
    }

    UserLocalInfo userLocalInfo = getUserInfo();

    final Map<String, dynamic> requestBody = {
      "subjectId": subjectID,
      "substituteTeacherId": teacherID,
      "date": _dateOfBirthController.text
    };

    final result = await http.post(
      Uri.parse('$apiBaseUrl/departments/assignProxy/assign'),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${userLocalInfo.token}', // Include the bearer token here
      },
    );
    // Handle response

    if(result.statusCode==200){
      handleErrorMessages(result.body);
    }
  }

  @override
  void initState() {
    _dateOfBirthController = TextEditingController(text: "Select date");
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Assign proxy teacher',
            style: GoogleFonts.openSans(fontSize: width * 0.04),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[300],
        bottomSheet: SizedBox(
          height: width * 0.2,
          width: width,
          child: Center(
            child: TextButton(
              onPressed: submitData,
              child: Text(
                'Assign',
                style: GoogleFonts.openSans(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            subjectName= value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return subjects.map((SubjectModelForProxy subject) {
                            return PopupMenuItem<String>(
                              onTap: (){
                                subjectID=subject.id;
                              },
                              value: subject.name.toString(),
                              child: Text(subject.name.toString()),
                            );
                          }).toList();
                        },
                        child: ListTile(
                          title: Text(subjectName?? 'Select Subject'),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            teacherName = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return teachers.map((TeacherModelForProxy teacher) {
                            return PopupMenuItem<String>(
                              value: teacher.name.toString(),
                              onTap: (){
                                teacherID=teacher.id;
                              },
                              child:  Text(
                                  teacher.name.toString(),
                                ),
                            );
                          }).toList();
                        },
                        child: ListTile(
                          title: Text(teacherName ?? 'Select Teacher'),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        surfaceTintColor: Colors.orange,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.32,
                          width: MediaQuery.of(context).size.width * 0.32,
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              showCustomDatePicker(context);
                            },
                            icon: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ),
                                Text(_dateOfBirthController.text, style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width*0.04
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
