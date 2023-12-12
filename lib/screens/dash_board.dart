import 'package:flutter/material.dart';
import 'package:untitled/components/dashboard_screen/classes_assigned_posts.dart';
import 'package:untitled/components/dashboard_screen/dashboard_app_bar.dart';
import 'package:untitled/components/dashboard_screen/dashboard_functions.dart';
import 'package:untitled/components/global/padded_text.dart';
import 'package:untitled/models/assigned_class_models.dart';

import '../components/semester_attendance_screen/no_attendance_records.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<ClassSchedule> classAssignedList = [];
  bool isLoading = true; // Added loading state

  fetchSubjects() async {
    classAssignedList = await getSubjectsAssigned();
    setState(() {
      isLoading = false; // Set loading to false when data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 75),
          child: const DashBoardAppBar(),
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const PaddedText(text: 'YOUR CLASSES'),
              const SizedBox(height: 30),
              isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
              ) // Show loading indicator
                  : classAssignedList.isEmpty
                      ? const NoClassesAssigned()
                      : ClassesAssignedPost(schedule: classAssignedList)
            ],
          ),
        ),
      ),
    );
  }
}
