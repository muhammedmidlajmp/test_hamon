import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/domain/classroom_model/classroom_model.dart';
import 'package:test_hamon/domain/student_model/student_model.dart';
import 'package:test_hamon/presentation/provider/classroom_provider/classroom_provider.dart';
import 'package:test_hamon/presentation/provider/student_list_provider/student_list_provider.dart';
import 'package:test_hamon/presentation/provider/subject_provider/subject_list_provider.dart';
import 'package:test_hamon/presentation/student_screen/student_register_screen.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentsProvider =
        Provider.of<StudentsProvider>(context, listen: false);
    final subjectProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
    subjectProvider.fetchSubjects();
    final classProvider =
        Provider.of<ClassroomProvider>(context, listen: false);
    classProvider.fetchClassrooms();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .5,
        flexibleSpace: Card(
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 244, 240, 240),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
        ),
        bottomOpacity: 10,
        leading: const Icon(Icons.subject_sharp),
        title: Text(
          "Student's List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentRegisterScreen(),
                    ));
              },
              icon: const Icon(Icons.all_inbox),
              label: const Text('View Register'))
        ],
      ),
      body: FutureBuilder(
        future: studentsProvider.fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Student> students = studentsProvider.students;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        students[index].id.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    title: Text(
                      students[index].name,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 17, 19, 152)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email : ${students[index].email.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Age : ${students[index].age.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: TextButton.icon(
                      icon: const Icon(Icons.add),
                      label: Text(
                        'Add Register',
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                      onPressed: () {
                        _showAssignmentDialog(context, students[index].id);
                      },
                    ),
                    onTap: () {
                      // Handle onTap
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showAssignmentDialog(BuildContext context, int student) {
    final studentsProvider =
        Provider.of<StudentsProvider>(context, listen: false);
    Classroom? selectedClassroom; // Track the selected classroom

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assign Student to Classroom'),
          content: Consumer<ClassroomProvider>(
            builder: (context, classroomProvider, child) {
              List<Classroom> classrooms = classroomProvider.classroom;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Classroom>(
                    items: classrooms.map((Classroom classroom) {
                      return DropdownMenuItem<Classroom>(
                        value: classroom,
                        child: Text(classroom.name),
                      );
                    }).toList(),
                    onChanged: (Classroom? selected) {
                      // Update the selected classroom
                      selectedClassroom = selected;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Choose Classroom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (selectedClassroom != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Selected Classroom: ${selectedClassroom!.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (selectedClassroom != null) {
                            // Assign student to the selected classroom
                            bool success =
                                await studentsProvider.assignSubjectToStudent(
                              student: student,
                              subject: selectedClassroom!
                                  .id, // Use the selected classroom's ID as the subject
                            );

                            if (success) {
                              // Show success message
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Assignment successful'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            } else {
                              // Show error message
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Assignment failed'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }

                            if (context.mounted) {
                              Navigator.of(context).pop(); // Close the dialog
                            }
                          }
                        },
                        child: const Text('Assign'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

  // void _removeStudentFromClassroom(BuildContext context, Student student) {
  //   // Check if the student is assigned to a classroom
  //   if (student.classroomId == null) {
  //     // Student is not assigned, handle accordingly (maybe show a message)
  //     return;
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Remove Student from Classroom'),
  //         content: Text(
  //             'Are you sure you want to remove ${student.name} from the classroom?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Remove student from the classroom
  //               student.removeFromClassroom();
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: const Text('Remove'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

