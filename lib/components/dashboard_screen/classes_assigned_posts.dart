import 'package:flutter/material.dart';
import 'package:untitled/components/dashboard_screen/classes_assigned_item_card.dart';
import 'package:untitled/models/assigned_class_models.dart';

class ClassesAssignedPost extends StatelessWidget {
  final List<ClassSchedule> schedule;
  const ClassesAssignedPost({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedule
          .map((classAssignedItem) =>
          ClassAssignedCard(schedule: classAssignedItem, proxy: classAssignedItem.proxy,))
          .toList(),
    );
  }
}


class ViewAttendanceForASubjectPost extends StatelessWidget {
  final List<ClassSchedule> schedule;
  const ViewAttendanceForASubjectPost({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedule
          .map((classAssignedItem) =>
          CardForViewingAttendanceOnly(schedule: classAssignedItem))
          .toList(),
    );
  }
}
