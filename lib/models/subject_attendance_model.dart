class AttendanceDetailModel {
  String date;
  bool present;

  AttendanceDetailModel({
    required this.date,
    required this.present,
  });

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      date: json['date'] ?? '',
      present: json['present'] ?? false,
    );
  }
}

class SubjectAttendanceModel {
  String name;
  String rollNumber;
  List<AttendanceDetailModel> attendance;
  SubjectAttendanceModel({
    required this.name,
    required this.rollNumber,
    required this.attendance,
  });

  factory SubjectAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SubjectAttendanceModel(
      name: json['name'] ?? '',
      rollNumber: json['rollNumber'] ?? '',
      attendance: (json['attendance'] as List<dynamic>?)
              ?.map((detail) => AttendanceDetailModel.fromJson(detail))
              .toList() ??
          [],
    );
  }
}
