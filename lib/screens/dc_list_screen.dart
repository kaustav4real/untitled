import 'package:flutter/material.dart';
import 'package:untitled/components/generate_csv/generate_csv_btn.dart';
import '../components/generate_pdf/download_nc_pdf_btn.dart';
import '../components/semester_attendance_screen/semester_attendance_list_item.dart';
import '../models/subject_attendance_model.dart';

class DCListScreen extends StatefulWidget {
  final List<SubjectAttendanceModel> dcList;
  final String subjectName, subjectID;

  const DCListScreen({Key? key, required this.dcList, required this.subjectName, required this.subjectID}) : super(key: key);

  @override
  State<DCListScreen> createState() => _DCListScreenState();
}

class _DCListScreenState extends State<DCListScreen> {
  late List<SubjectAttendanceModel> filteredList;
  @override
  void initState() {
    // TODO: implement initState
    filteredList = widget.dcList.where((student) {
      int totalClasses = student.attendance.length;
      if (totalClasses > 0) {
        double attendancePercentage =
            (student.attendance.where((detail) => detail.present).length /
                totalClasses) *
                100;
        return attendancePercentage < 65;
      } else {
        // If there are no classes, consider the student for filtering
        return true;
      }
    }).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('DC List'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.width * 0.09),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DownloadNCListPdf(
                      data: filteredList,
                      subjectName: widget.subjectName,
                      subjectID: widget.subjectID,
                      message: 'Dis-Collegiate List',
                    ),
                    DownloadAttendanceCSV(data: filteredList)
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: filteredList.isEmpty
                      ? [const Text('No student is being discollegiated.')]
                      : filteredList
                          .map(
                            (item) => SemesterAttendanceListItem(
                              rollNumber: item.rollNumber,
                              studentName: item.name,
                              attendanceList: item.attendance,
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
