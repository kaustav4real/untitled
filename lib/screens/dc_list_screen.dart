import 'package:flutter/material.dart';
import '../components/semester_attendance_screen/semester_attendance_list_item.dart';
import '../models/subject_attendance_model.dart';

class DCListScreen extends StatelessWidget {
  final List<SubjectAttendanceModel> dcList;

  const DCListScreen({Key? key, required this.dcList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter the list based on attendance criteria
    List<SubjectAttendanceModel> filteredList = dcList.where((student) {
      int totalClasses = student.attendance.length;
      if (totalClasses > 0) {
        double attendancePercentage = (student.attendance.where((detail) => detail.present).length / totalClasses) * 100;

        // Filter criteria: Attendance less than 75% and greater than or equal to 65%
        return attendancePercentage < 65;
      } else {
        // If there are no classes, consider the student for filtering
        return true;
      }
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('DC List'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical:MediaQuery.of(context).size.width * 0.09),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: filteredList.isEmpty
                  ? [const Text('No student is being discollegiated.')]
                  : filteredList.map((item) => SemesterAttendanceListItem(
                rollNumber: item.rollNumber,
                studentName: item.name,
                attendanceList: item.attendance,
              ),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
