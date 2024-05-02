class TeacherModelForProxy{
  String name;
  int id;
  TeacherModelForProxy({
    required this.name,
    required this.id
});

  factory TeacherModelForProxy.fromJson(Map<String, dynamic> jsonData){
    return TeacherModelForProxy(name: jsonData['name'] , id: jsonData['id']);
  }
}

class SubjectModelForProxy{
  String name,id;
  SubjectModelForProxy({
    required this.name,
    required this.id
});

  factory SubjectModelForProxy.fromJson(Map<String, dynamic> jsonData){
    return SubjectModelForProxy(name: jsonData['name'], id: jsonData['id']);
  }
}