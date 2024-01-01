class Student {
  int age;
  String email;
  int id;
  String name;

  Student({
    required this.age,
    required this.email,
    required this.id,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      age: json['age'] as int,
      email: json['email'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'email': email,
      'id': id,
      'name': name,
    };
  }
}

class StudentsList {
  List<Student> students;

  StudentsList({required this.students});

  factory StudentsList.fromJson(List<dynamic> json) {
    List<Student> studentList = json.map((e) => Student.fromJson(e)).toList();
    return StudentsList(students: studentList);
  }

  List<Map<String, dynamic>> toJson() {
    return students.map((e) => e.toJson()).toList();
  }
}
