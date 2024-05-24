import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/components/dashboard_screen/no_classes_assigned_card.dart';

import '../components/global/custom_snackbar.dart';
import '../constants.dart';
import '../database/user_model_db__functions.dart';
import '../helpers/date_functions.dart';
import '../models/subject_attendance_model.dart';
import '../models/user_model.dart';

class ViewAttendanceByDateScreen extends StatefulWidget {
  final String subjectID;
  const ViewAttendanceByDateScreen({super.key, required this.subjectID});

  @override
  State<ViewAttendanceByDateScreen> createState() =>
      _ViewAttendanceByDateScreenState();
}

class _ViewAttendanceByDateScreenState
    extends State<ViewAttendanceByDateScreen> {
  static const String url = '$apiBaseUrl/attendance/details';
  UserLocalInfo info = getUserInfo();
  bool isLoading = false;
  bool dataNotFound=false;
  late TextEditingController _dateController;
  int classNumber = 1;
  String callingDate="";
  List<SubjectAttendanceModel> fetchedList = [];

  handleErrorMessages(String message) {
    showCustomSnackBar(context, message);
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
            firstDate: DateTime(2023),
            lastDate: DateTime.now(),
            // Customize other properties if needed
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateController.text = getDateInYYYYMMDDFromArgument(value);
        });
      }
      return null;
    });
  }

  handleSuccessfulProxyAssignment(String message) {
    showCustomSnackBar(context, message);
  }

  void handleErrors(String message) {
    showCustomSnackBar(context, message);
  }

  Future<void> fetchStudentsList() async {
    setState(() {
      isLoading = true;
      callingDate=_dateController.text;
    });
    try {
      final response = await http.get(
          Uri.parse(
              '$url/${widget.subjectID}/${_dateController.text}/$classNumber'),
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
          fetchedList.sort((a, b) => a.rollNumber.compareTo(b.rollNumber));
          isLoading = false;
          if (fetchedList.isEmpty){
            dataNotFound=true;
          }else{
            dataNotFound=false;
          }
        });
      } else {
        handleErrors('Failed to fetch attendance data');
      }
    } catch (error) {
      handleErrors(error.toString());
    }
  }

  @override
  void initState() {
    _dateController = TextEditingController(text: "Select Date");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Attendance',
          style: GoogleFonts.openSans(fontSize: width * 0.04),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          right: width * 0.04,
          left: width * 0.04,
          top: 30,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  surfaceTintColor: Colors.orange,
                  child: Container(
                    height: width * 0.28,
                    width: width * 0.28,
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        showCustomDatePicker(context);
                      },
                      icon: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: MediaQuery.of(context).size.width * 0.08),
                          Text(
                            _dateController.text,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.026,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.55,
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        classNumber = int.parse(value);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return classNumberList.map((int classNum) {
                        return PopupMenuItem<String>(
                          onTap: () {
                            classNumber = classNum;
                          },
                          value: classNum.toString(),
                          child: Text(
                            classNum.toString(),
                          ),
                        );
                      }).toList();
                    },
                    child: ListTile(
                      title: Text('Class number $classNumber'),
                      trailing: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Colors.purple
                )
              ),
              onPressed: () async {
                await fetchStudentsList();
              },
              child: const Text('Get Attendance'),
            ),
            const SizedBox(height: 20),
            callingDate != ""
                ? Text(
                    'Attendance on ${_dateController.text} (class $classNumber)',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(100, 100, 111, 0.2),
                          blurRadius: 29,
                          spreadRadius: 0,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      children: fetchedList
                          .map(
                            (e) => ListTile(
                              title: Text(
                                e.rollNumber,
                                style: GoogleFonts.openSans(
                                    fontSize: width * 0.038,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                e.name,
                                style: GoogleFonts.openSans(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              trailing: e.attendance[0].present
                                  ? Icon(
                                      Icons.check,
                                      size: width * 0.06,
                                    )
                                  : Icon(
                                      Icons.cancel,
                                      size: width * 0.06,
                                    ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
            dataNotFound?
                const NoAttendanceRecords():
                const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
