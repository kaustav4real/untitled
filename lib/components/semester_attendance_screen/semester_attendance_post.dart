import 'package:flutter/material.dart';
import 'package:untitled/components/dashboard_screen/no_classes_assigned_card.dart';
import 'package:untitled/components/generate_pdf/download_attendance_pdf.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_functions.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_list_item.dart';
import 'package:untitled/models/subject_attendance_model.dart';
import 'package:untitled/screens/nc_list_screen.dart';
import '../../screens/dc_list_screen.dart';

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
  List<SubjectAttendanceModel> classAssignedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
        : Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFFe1af16),
                      ),
                      child: TextButton(
                        onPressed: () {
                          nextScreen(
                              context,
                              NCListScreen(
                                dcList: classAssignedList,
                                subjectName: widget.subjectName,
                                subjectID: widget.subjectID,
                              ));
                        },
                        child: const Text(
                          'NC List',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFF991111),
                      ),
                      child: TextButton(
                        onPressed: () {
                          nextScreen(
                              context, DCListScreen(dcList: classAssignedList, subjectID: widget.subjectID,subjectName:widget.subjectName ,));
                        },
                        child: const Text(
                          'DC List',
                          style: TextStyle(
                            color: Color(0XFFf3f6ed),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    DownloadAttendancePdf(data: classAssignedList, label: '',),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
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
              ),
            ],
          );
  }
}
