import 'package:flutter/material.dart';
import 'package:untitled/components/dashboard_screen/classes_assigned_posts.dart';
import 'package:untitled/components/dashboard_screen/dashboard_app_bar.dart';
import 'package:untitled/components/dashboard_screen/no_classes_assigned_card.dart';
import 'package:untitled/components/global/padded_text.dart';
import 'package:untitled/models/assigned_class_models.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    List<ClassSchedule> classAssignedList = [
      ClassSchedule(
        subjectName: 'Formal Language And Theory Of Automation  ',
        departmentName: 'Computer Science & Engineering',
        semester: '5th',
      ),
      ClassSchedule(
        subjectName: 'Distributed Systems',
        departmentName: 'Computer Science & Engineering',
        semester: '7th',
      ),
      ClassSchedule(
        subjectName: 'Data Structures and Algorithms',
        departmentName: 'Computer Science & Engineering',
        semester: '3rd',
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 75),
          child: const DashBoardAppBar(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const PaddedText(text: 'YOUR CLASSES'),
              const SizedBox(height: 30),
              classAssignedList.isEmpty
                  ? const NoClassesAssigned()
                  : ClassesAssignedPost(schedule: classAssignedList)
            ],
          ),
        ),
      ),
    );
  }
}
