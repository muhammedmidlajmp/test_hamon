// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';
// import 'package:test_hamon/domain/subject_model/subject_model.dart';
// import 'package:test_hamon/presentation/provider/classroom_provider/classroom_provider.dart';

// // ignore: must_be_immutable
// class AssignSubjectShowdiolog extends StatelessWidget {
//   AssignSubjectShowdiolog(
//       {super.key,
//       required this.id,
//       required this.name,
//       required this.classroomId,
//       required this.subjects,required this.request});
//   int id;
//   String name;
//   int classroomId;
//   List<Subject> subjects;
//   UpdateClassroomRequest request;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Consumer<ClassroomProvider>(
//         builder: (context, classroomProvider, child) => AlertDialog(
//           title: const Text('Assign Subject'),
//           content: DropdownButtonFormField<Subject>(
//             value: null,
//             items: subjects.map((Subject subject) {
//               return DropdownMenuItem<Subject>(
//                 value: subject,
//                 child: Text(subject.name),
//               );
//             }).toList(),
//             onChanged: (Subject? selectedSubject) {
//               request.subject = selectedSubject!.id;
//             },
//             decoration: const InputDecoration(
//               labelText: 'Choose Subject',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (request.subject != null) {
//                   bool success =
//                       await classroomProvider.assignSubjectToClassroom(request);
//                   print(request.subject);

//                   if (context.mounted) {
//                     Navigator.of(context).pop(); // Close the dialog

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(success
//                             ? 'Assignment successful'
//                             : 'Assignment failed'),
//                         backgroundColor: success ? Colors.green : Colors.red,
//                       ),
//                     );
//                   }
//                 } else {
//                   // Show error or handle empty subject
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please choose a subject'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Assign'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
