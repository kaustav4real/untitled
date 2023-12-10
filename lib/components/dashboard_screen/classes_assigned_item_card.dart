import 'package:flutter/material.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/models/assigned_class_models.dart';
import 'package:untitled/screens/semester_attendance_screen.dart';

class ClassAssignedCard extends StatelessWidget {
  final ClassSchedule schedule;
  const ClassAssignedCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          height: 160,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(schedule.departmentName,
                            style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          schedule.subjectName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      '${schedule.semester} Semester',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF90CAF9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  nextScreen(context, SemesterScreen(
                      semester: schedule.semester.toString(),
                      subjectID: schedule.subjectId,
                  )
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
