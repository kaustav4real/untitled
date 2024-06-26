import 'package:flutter/material.dart';
import 'package:untitled/components/generate_csv/generate_csv_btn.dart';
import 'package:untitled/components/generate_pdf/download_attendance_pdf.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_functions.dart';
import 'package:untitled/models/subject_attendance_model.dart';
import 'package:untitled/screens/nc_list_screen.dart';
import '../../screens/dc_list_screen.dart';

class SemesterAttendanceListsItem extends StatefulWidget {
  final String subjectName;
  final String subjectID;
  const SemesterAttendanceListsItem(
      {Key? key, required this.subjectID, required this.subjectName})
      : super(key: key);

  @override
  State<SemesterAttendanceListsItem> createState() =>
      _SemesterAttendanceListsItemState();
}

class _SemesterAttendanceListsItemState
    extends State<SemesterAttendanceListsItem> {
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
    final width = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator()) // Show loading indicator
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.42,
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
                  Container(
                    width: width * 0.42,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFF991111),
                    ),
                    child: TextButton(
                      onPressed: () {
                        nextScreen(
                            context,
                            DCListScreen(
                              dcList: classAssignedList,
                              subjectID: widget.subjectID,
                              subjectName: widget.subjectName,
                            ));
                      },
                      child: const Text(
                        'DC List',
                        style: TextStyle(
                          color: Color(0XFFf3f6ed),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: DownloadAttendancePdf(data: classAssignedList, label:'All Students ',)),
                  SizedBox(
                    width: width * 0.06,
                  ),
                  Expanded(
                    child: DownloadAttendanceCSV(data: classAssignedList, label:'All Students '),
                  )
                ],
              )
            ],
          );
  }
}
