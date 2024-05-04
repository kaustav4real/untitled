class ClassSchedule {
  String subjectName;
  String subjectId;
  String departmentName;
  int semester;
  bool proxy;
  ClassSchedule({
    required this.departmentName,
    required this.subjectName,
    required this.subjectId,
    required this.semester,
    required this.proxy,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
        departmentName: json['department'] ??'',
        subjectName: json['subject'] ?? '',
        subjectId: json['subjectId'] ?? '',
        semester: json['semester'] ?? 0,
        proxy: json['proxy'] ?? false);
  }
}

class AllClassScheduleDTO {
  List<ClassSchedule> ownSubjects;
  List<ClassSchedule> assignedSubjects;
  AllClassScheduleDTO({
    required this.ownSubjects,
    required this.assignedSubjects,
  });
}
