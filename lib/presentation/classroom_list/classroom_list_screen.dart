import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/domain/classroom_model/classroom_model.dart';
import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';
import 'package:test_hamon/domain/subject_model/subject_model.dart';

import 'package:test_hamon/presentation/provider/classroom_provider/classroom_provider.dart';
import 'package:test_hamon/presentation/provider/subject_provider/subject_list_provider.dart';

class ClassroomListScreen extends StatelessWidget {
  const ClassroomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classroomProvider =
        Provider.of<ClassroomProvider>(context, listen: false);
    final subjectProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
    subjectProvider.fetchSubjects();

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
          "Classroom List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: classroomProvider.fetchClassrooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Classroom> classrooms = classroomProvider.classroom;
            List<Subject> subjects = subjectProvider.subjects;
            return ListView.builder(
              itemCount: classrooms.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        classrooms[index].id.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    title: Text(
                      classrooms[index].name,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 17, 19, 152)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Layout : ${classrooms[index].layout.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Size : ${classrooms[index].size.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Icon(Icons.add),
                        Flexible(
                          child: TextButton(
                            child: Text('Add Subject'),
                            onPressed: () {
                              _showAssignSubjectDialog(
                                  context, classrooms[index].id, subjects,
                                  size: classrooms[index].size,
                                  layout: classrooms[index].layout,
                                  name: classrooms[index].name);
                            },
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _showClassroomDetailsDialog(context, subjects,
                          layout: classrooms[index].layout,
                          name: classrooms[index].name,
                          classroomId: classrooms[index].id);
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

  void _showClassroomDetailsDialog(BuildContext context, List<Subject> subjects,
      {required name, required classroomId, required layout}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Consumer<ClassroomProvider>(
            builder: (context, value, child) => AlertDialog(
              title: Text(name),
              content: FutureBuilder<UpdateClassroomRequest>(
                future: value.fetchIndividualClassroom(classroomId),
                builder:
                    (context, AsyncSnapshot<UpdateClassroomRequest> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    // Data is successfully loaded
                    UpdateClassroomRequest classroom = snapshot.data!;

                    // Now you can use the classroom object to display data in your widget
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 214, 217, 221),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Classroom ID: ${classroom.id.toString()}'),
                                Text('Layout: ${classroom.layout.toString()}'),
                                Text('Name: ${classroom.name}'),
                                Text('Size: ${classroom.size.toString()}'),
                                Text(
                                    'Subject: ${classroom.subject.toString() ?? 'NO Subjecy'}'),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Back')),
                                  ],
                                ),
                                // Add more widgets to display other properties
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAssignSubjectDialog(
    BuildContext context,
    int classroomId,
    List<Subject> subjects, {
    required name,
    required size,
    required layout,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        UpdateClassroomRequest request = UpdateClassroomRequest(
          id: classroomId,
          layout: layout,
          name: name,
          size: size,
          subject: 0,
        );

        return SingleChildScrollView(
          child: Consumer<ClassroomProvider>(
            builder: (context, classroomProvider, child) => AlertDialog(
              title: const Text('Assign Subject'),
              content: DropdownButtonFormField<Subject>(
                value: null,
                items: subjects.map((Subject subject) {
                  return DropdownMenuItem<Subject>(
                    value: subject,
                    child: Text(subject.name),
                  );
                }).toList(),
                onChanged: (Subject? selectedSubject) {
                  request.subject = selectedSubject!.id;
                },
                decoration: const InputDecoration(
                  labelText: 'Choose Subject',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (request.subject != null) {
                      bool success = await classroomProvider
                          .assignSubjectToClassroom(request);
                      print(request.subject);

                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close the dialog

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? 'Assignment failed'
                                : 'Assignment successful'),
                            backgroundColor:
                                success ? Colors.red : Colors.green,
                          ),
                        );
                      }
                    } else {
                      // Show error or handle empty subject
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please choose a subject'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Assign'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
