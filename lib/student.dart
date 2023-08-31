class Student{
  String name;
  String attendance;
  String? absentReason;

  Student({
    required this.name,
    required this.attendance,
    this.absentReason
  });

  Student.fromJson(Map<String, dynamic> json) :
      name = json['name'],
      attendance = json['attendance'],
      absentReason = json['absentReason'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'attendance' : attendance,
    'absentReason' : absentReason
  };
}