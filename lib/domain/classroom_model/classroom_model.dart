class Classroom {
  int id;
  String layout;
  String name;
  int size;

  Classroom({
    required this.id,
    required this.layout,
    required this.name,
    required this.size,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'] as int,
      layout: json['layout'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'layout': layout,
      'name': name,
      'size': size,
    };
  }
}

class ClassroomsList {
  List<Classroom> classrooms;

  ClassroomsList({required this.classrooms});

  factory ClassroomsList.fromJson(List<dynamic> json) {
    List<Classroom> classroomList =
        json.map((e) => Classroom.fromJson(e)).toList();
    return ClassroomsList(classrooms: classroomList);
  }

  List<Map<String, dynamic>> toJson() {
    return classrooms.map((e) => e.toJson()).toList();
  }
}
