// class IndividualClassroom {
//   int id;
//   String layout;
//   String name;
//   int size;
//   String subject;

//   IndividualClassroom({
//     required this.id,
//     required this.layout,
//     required this.name,
//     required this.size,
//     required this.subject,
//   });

//   factory IndividualClassroom.fromJson(Map<String, dynamic> json) {
//     return IndividualClassroom(
//       id: json['id'] as int,
//       layout: json['layout'] as String,
//       name: json['name'] as String,
//       size: json['size'] as int,
//       subject: json['subject'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'layout': layout,
//       'name': name,
//       'size': size,
//       'subject': subject,
//     };
//   }
// }

// class IndividualClassroomList {
//   List<IndividualClassroom> individualClassrooms;

//   IndividualClassroomList({required this.individualClassrooms});

//   factory IndividualClassroomList.fromJson(List<dynamic> json) {
//     List<IndividualClassroom> individualClassroomList =
//         json.map((e) => IndividualClassroom.fromJson(e)).toList();
//     return IndividualClassroomList(individualClassrooms: individualClassroomList);
//   }

//   List<Map<String, dynamic>> toJson() {
//     return individualClassrooms.map((e) => e.toJson()).toList();
//   }
// }
