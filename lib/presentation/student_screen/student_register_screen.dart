import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/domain/student_register_model/student_register_model.dart';
import 'package:test_hamon/presentation/provider/student_list_provider/student_list_provider.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentsProvider =
        Provider.of<StudentsProvider>(context, listen: false);
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          "Register List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: studentsProvider.fetchRegister(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Registration> register = studentsProvider.register;
            return ListView.builder(
              itemCount: register.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        register[index].id.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    title: Text(
                      "Student Id : ${register[index].student.toString()}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      "Subject Id : ${register[index].subject.toString()}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(
                            context, register[index].id);
                      },
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      ),
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

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int rgstrId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<StudentsProvider>(
          builder: (context, studentsProvider, child) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to delete this registration?'),
                ],
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
                onPressed: () {
                  // Call deleteRegister when user confirms deletion
                  studentsProvider.deleteRegister(rgstrId);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
