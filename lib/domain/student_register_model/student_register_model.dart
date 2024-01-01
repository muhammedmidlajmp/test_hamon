

class Registration {
  int id;
  int student;
  int subject;

  Registration({
    required this.id,
    required this.student,
    required this.subject,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'] as int,
      student: json['student'] as int,
      subject: json['subject'] as int,
    );
  }
}
class RegistrationList {
  List<Registration> registrations;

  RegistrationList({required this.registrations});

  factory RegistrationList.fromJson(Map<String, dynamic> json) {
    List<Registration> registrationList = (json['registrations'] as List)
        .map((registration) => Registration.fromJson(registration))
        .toList();
    return RegistrationList(registrations: registrationList);
  }
}