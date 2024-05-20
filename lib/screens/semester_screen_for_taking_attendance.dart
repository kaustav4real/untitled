import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/components/global/custom_snackbar.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_post.dart';
import 'package:untitled/helpers/date_functions.dart';
import 'package:untitled/screens/take_attendance_screen.dart';

import '../constants.dart';
import '../database/user_model_db__functions.dart';
import '../models/user_model.dart';

class SemesterScreen extends StatefulWidget {
  final String semester, subjectID, subjectName;
  final bool proxy;
  const SemesterScreen(
      {super.key,
      required this.semester,
      required this.subjectID,
        required this.subjectName,
      required this.proxy});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  @override
  Widget build(BuildContext context) {
    String url = '$apiBaseUrl/attendance/takeAttendance';

    reDirectOnSuccess(String subjectID, String date, int classNumber) {
      nextScreen(
        context,
        TakeAttendanceScreen(
          subjectID: subjectID,
          date: date,
          classNumber: classNumber,
        ),
      );
    }

    handleErrors(String message) {
      showCustomSnackBar(context, message);
    }

    takeAttendanceHandler() async {
      setState(() {});
      try {
        String date = getDateYYYYMMDD();
        UserLocalInfo info = getUserInfo();
        final httpBody = jsonEncode({
          'subjectID': widget.subjectID,
          'date': date,
          'proxy': widget.proxy,
        });

        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${info.token}',
          },
          body: httpBody,
        );

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body)['data'];
          reDirectOnSuccess(
            jsonData['subjectID'],
            jsonData['date'],
            jsonData['classNumber'],
          );
          return;
        } else {
          handleErrors('Unknown error has occurred');
        }
      } catch (error) {
        handleErrors(error.toString());
      }
    }
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '${widget.semester} Semester',
            style: GoogleFonts.openSans(fontSize: width * 0.046),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  'Attendance as of ${getTodayDate()}',
                  style: GoogleFonts.openSans(fontSize: width * 0.046),
                ),
                const SizedBox(height: 20),
                SemesterAttendanceLists(subjectID: widget.subjectID, subjectName: widget.subjectName,),
              ],
            ),
          ),
        ),
        bottomSheet: GestureDetector(
          onTap: () async {
            await takeAttendanceHandler();
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0XFF4e6e5d),
            ),
            child: Center(
              child: Text(
                'Take Attendance',
                style: GoogleFonts.notoSans(
                    color: const Color(0XFFf3f6ed),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
