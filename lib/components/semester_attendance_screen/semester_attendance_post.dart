import 'package:flutter/material.dart';
import 'package:untitled/components/dashboard_screen/no_classes_assigned_card.dart';

import 'package:untitled/components/semester_attendance_screen/semester_attendance_functions.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_list_item.dart';
import 'package:untitled/models/subject_attendance_model.dart';

class SemesterAttendanceLists extends StatefulWidget {
  final String subjectName;
  final String subjectID;
  const SemesterAttendanceLists(
      {Key? key, required this.subjectID, required this.subjectName})
      : super(key: key);

  @override
  State<SemesterAttendanceLists> createState() =>
      _SemesterAttendanceListsState();
}

class _SemesterAttendanceListsState extends State<SemesterAttendanceLists> {
  late TextEditingController textEditingController;
  List<SubjectAttendanceModel> classAssignedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    textEditingController=TextEditingController();
    fetchSubjects();
  }

  fetchSubjects() async {
    List<SubjectAttendanceModel> fetchedList =
        await getSemesterAttendance(widget.subjectID);

    setState(() {
      fetchedList.sort((a, b) => a.rollNumber.compareTo(b.rollNumber));
      classAssignedList = fetchedList;
      isLoading = false; // Set loading to false when data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator()) // Show loading indicator
        : Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: classAssignedList.isEmpty
                ? [const NoAttendanceRecords()]
                : classAssignedList
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
