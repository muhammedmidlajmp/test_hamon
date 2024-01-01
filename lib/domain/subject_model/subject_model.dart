class Subject {
  int credits;
  int id;
  String name;
  String teacher;

  Subject({
    required this.credits,
    required this.id,
    required this.name,
    required this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      credits: json['credits'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      teacher: json['teacher'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'credits': credits,
      'id': id,
      'name': name,
      'teacher': teacher,
    };
  }
}

class SubjectsList {
  List<Subject> subjects;

  SubjectsList({required this.subjects});

  factory SubjectsList.fromJson(List<dynamic> json) {
    List<Subject> subjectList = json.map((e) => Subject.fromJson(e)).toList();
    return SubjectsList(subjects: subjectList);
  }

  List<Map<String, dynamic>> toJson() {
    return subjects.map((e) => e.toJson()).toList();
  }
}
