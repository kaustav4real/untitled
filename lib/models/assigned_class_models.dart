class ClassSchedule {
  String subjectName;
  String subjectId;
  String departmentName;
  int semester;
  ClassSchedule({
    required this.departmentName,
    required this.subjectName,
    required this.subjectId ,
    required this.semester,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      departmentName: json['department'] ?? '', // Adjust the key names based on your actual response
      subjectName: json['subject'] ?? '',
      subjectId: json['subjectId'] ?? '',
      semester: json['semester'] ?? 0,
    );
  }


}