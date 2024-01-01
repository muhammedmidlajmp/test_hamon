class UpdateClassroomRequest {
  int id;
  String layout;
  String name;
  int size;
  int? subject;

  UpdateClassroomRequest({
    required this.id,
    required this.layout,
    required this.name,
    required this.size,
    required this.subject,
  });
  factory UpdateClassroomRequest.fromJson(Map<String, dynamic> json) {
    return UpdateClassroomRequest(
      id: json['id'] as int,
      layout: json['layout'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
      subject: json['subject'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'layout': layout,
      'name': name,
      'size': size,
      'subject': subject,
    };
  }
}

class UpdateClassroomList {
  List<UpdateClassroomRequest> individualClassrooms;

  UpdateClassroomList({required this.individualClassrooms});

  factory UpdateClassroomList.fromJson(List<dynamic> json) {
    List<UpdateClassroomRequest> individualClassroomList =
        json.map((e) => UpdateClassroomRequest.fromJson(e)).toList();
    return UpdateClassroomList(individualClassrooms: individualClassroomList);
  }

  List<Map<String, dynamic>> toJson() {
    return individualClassrooms.map((e) => e.toJson()).toList();
  }
}
