import 'package:flutter/material.dart';
import 'package:untitled/components/semester_attendance_screen/semester_attendance_list_item.dart';

class StudentModel {
  final String name;
  final String rollNumber;
  final String attendance;

  StudentModel({
    required this.name,
    required this.rollNumber,
    required this.attendance,
  });
}

List<StudentModel> model = [
  StudentModel(
      name: 'Kaustav Kakoty', rollNumber: '200710007026', attendance: '81'),
  StudentModel(
      name: 'Anurag Sahu', rollNumber: '200710007008', attendance: '87'),
  StudentModel(
      name: 'Nishit Bhardwaj', rollNumber: '200710007037', attendance: '82'),
  StudentModel(
      name: 'Zubayer Laskar Zidhan',
      rollNumber: '200710007062',
      attendance: '60'),
  StudentModel(
      name: 'Abdul Kadir Talukdar',
      rollNumber: '200710007001',
      attendance: '10'),
];

class SemesterAttendanceLists extends StatelessWidget {
  const SemesterAttendanceLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Column(
        children: model
            .map(
              (item) => SemesterAttendanceListItem(
                rollNumber: item.rollNumber,
                studentName: item.name,
                attendance: item.attendance,
              ),
            )
            .toList(),
      ),
    );
  }
}
