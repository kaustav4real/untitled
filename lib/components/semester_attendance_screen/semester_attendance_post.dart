import 'package:flutter/material.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_functions.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_list_item.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class SemesterAttendanceLists extends StatefulWidget {
  final String subjectID;
  const SemesterAttendanceLists({Key? key, required this.subjectID}) : super(key: key);

  @override
  State<SemesterAttendanceLists> createState() => _SemesterAttendanceListsState();
}

class _SemesterAttendanceListsState extends State<SemesterAttendanceLists> {
  List<SubjectAttendanceModel> classAssignedList = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  fetchSubjects() async {
    List<SubjectAttendanceModel> fetchedList = await getSemesterAttendance(widget.subjectID);
    setState(() {
      classAssignedList = fetchedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children:classAssignedList.isEmpty ?
        [Text('No attendnace taken')]: classAssignedList
            .map(
              (item) => SemesterAttendanceListItem(
            rollNumber: item.rollNumber,
            studentName: item.name,
            attendanceList: item.attendance,
          ),
        )
            .toList(),
      ),
    );
  }
}
