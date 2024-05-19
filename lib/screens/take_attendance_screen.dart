import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/components/global/custom_snackbar.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/models/subject_attendance_model.dart';
import 'package:untitled/screens/student_attendance_item_screen.dart';

import '../components/dashboard_screen/no_classes_assigned_card.dart';
import '../components/global/next_screen.dart';

class TakeAttendanceScreen extends StatefulWidget {
  final String subjectID, date;
  final int classNumber;

  const TakeAttendanceScreen({
    Key? key,
    required this.subjectID,
    required this.date,
    required this.classNumber,
  }) : super(key: key);

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  bool loading = true;
  late UserLocalInfo info;
  List<SubjectAttendanceModel> fetchedList = [];

  static const String url = '$apiBaseUrl/attendance/details';
  static const String endAttendanceUrl = '$apiBaseUrl/attendance/endAttendance';

  void handleErrors(String message) {
    showCustomSnackBar(context, message);
  }

  Future<void> fetchStudentsList() async {
    try {
      final response = await http.get(
          Uri.parse(
              '$url/${widget.subjectID}/${widget.date}/${widget.classNumber}'),
          headers: {
            'Authorization': 'Bearer ${info.token}',
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        List<SubjectAttendanceModel> attendanceList = jsonResponse
            .map((subjectData) => SubjectAttendanceModel.fromJson(subjectData))
            .toList();

        setState(() {
          fetchedList = attendanceList;
          // fetchedList = [SubjectAttendanceModel(
          //   name: 'Kla',
          //   rollNumber: 'Kla',
          //   attendance: [AttendanceDetailModel(date: 'kla', present: true, classNumber: 1)]
          // )];
          loading = false;
        });
        print(fetchedList);
      } else {
        handleErrors('Failed to fetch attendance data');
      }
    } catch (error) {
      handleErrors(error.toString());
    }
  }

  onSuccessRedirect() {
    Navigator.pop(context);
  }

  endAttendanceHandler() async {
    try {
      UserLocalInfo info = getUserInfo();

      final response = await http.post(
        Uri.parse(endAttendanceUrl),
        headers: {
          'Authorization': 'Bearer ${info.token}',
        },
      );

      if (response.statusCode == 200) {
        onSuccessRedirect();
        return;
      } else {
        handleErrors('Unknown error has occurred');
      }
    } catch (error) {
      handleErrors(error.toString());
    }
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    info = getUserInfo();
    fetchStudentsList();

    // Start a timer to call fetchStudentsList every 15 seconds after it has been initially loaded
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (!loading) {
        fetchStudentsList();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
              'Taking Attendance',
            style: GoogleFonts.openSans(
              fontSize: MediaQuery.of(context).size.width*0.046
            ),
          ),
        ),
        bottomSheet: GestureDetector(
          onTap: () async {
            await endAttendanceHandler();
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0XFF991111),
            ),
            child: Center(
              child: Text(
                'End Attendance',
                style: GoogleFonts.notoSans(
                    color: const Color(0XFFf3f6ed),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await fetchStudentsList();
          },
          child: fetchedList.isEmpty
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'No attendance record has been found yet.',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: fetchedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final attendance = fetchedList[index];
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15),
                      child: LiveAttendanceItem(
                        rollNumber: attendance.rollNumber,
                        studentName: attendance.name,
                        attendanceList: attendance.attendance,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class LiveAttendanceItem extends StatelessWidget {
  final String studentName, rollNumber;
  final List<AttendanceDetailModel> attendanceList;
  const LiveAttendanceItem(
      {super.key,
      required this.rollNumber,
      required this.studentName,
      required this.attendanceList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
              context,
              StudentsAttendanceItemScreen(
                rollNumber: rollNumber,
                name: studentName,
                attendanceList: attendanceList,
              ),
            );
          },
          child: ListTile(
            title: Text(studentName),
            subtitle: Text(rollNumber),
          ),
        ),
        const Divider(
          thickness: 0.3,
        )
      ],
    );
  }
}
