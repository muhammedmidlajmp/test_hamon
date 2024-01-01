import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';
import 'package:test_hamon/presentation/provider/classroom_provider/classroom_provider.dart';

// ignore: must_be_immutable
class ClassroomDetailsShowdilog extends StatelessWidget {
  ClassroomDetailsShowdilog({super.key, required this.id, required this.name});
  int id;
  String name;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ClassroomProvider>(
        builder: (context, value, child) => AlertDialog(
          title: Text(name),
          content: FutureBuilder<UpdateClassroomRequest>(
            future: value.fetchIndividualClassroom(id),
            builder: (context, AsyncSnapshot<UpdateClassroomRequest> snapshot) {
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
                            Text('Classroom ID: ${classroom.id.toString()}'),
                            Text('Layout: ${classroom.layout.toString()}'),
                            Text('Name: ${classroom.name}'),
                            Text('Size: ${classroom.size.toString()}'),
                            Text('Subject: ${classroom.subject.toString()}'),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Back')),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Change Subject')),
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
  }
}
