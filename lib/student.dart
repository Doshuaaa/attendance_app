class Student{
  String _name;
  final String _attendance;
  final String? _absentReason;


  Student({
    required String name,
    required String attendance,
    String? absentReason
  }) : _absentReason = absentReason, _attendance = attendance, _name = name;


  Student.fromJson(Map<String, dynamic> json) :
        _name = json['name'],
        _attendance = json['attendance'],
        _absentReason = json['absentReason'];

  Map<String, dynamic> toJson() => {
    'name' : _name,
    'attendance' : _attendance,
    'absentReason' : _absentReason
  };

  String get name => _name;

  String get attendance => _attendance;

  String? get absentReason => _absentReason;
}