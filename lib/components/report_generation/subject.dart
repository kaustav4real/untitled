import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/components/dashboard_screen/classes_assigned_posts.dart';
import 'package:untitled/components/dashboard_screen/dashboard_functions.dart';

import 'package:untitled/models/assigned_class_models.dart';

class AllSubjectsForReportGeneration extends StatefulWidget {
  const AllSubjectsForReportGeneration({super.key});

  @override
  State<AllSubjectsForReportGeneration> createState() =>
      _AllSubjectsForReportGenerationState();
}

class _AllSubjectsForReportGenerationState extends State<AllSubjectsForReportGeneration> {
  late AllClassScheduleDTO allClasses;
  bool isLoading = true; // Added loading state

  fetchSubjects() async {
    final data = await getSubjectsAssigned();
    setState(() {
      allClasses = data;
    });
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Your classes',
            style: GoogleFonts.openSans(
              fontSize: MediaQuery.of(context).size.width * 0.046,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    allClasses.ownSubjects.isNotEmpty
                        ? ViewSubjectsForReportGeneration(
                            schedule: allClasses.ownSubjects)
                        : const Center(
                            child: Text('No classes hae been assigned to you'),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
