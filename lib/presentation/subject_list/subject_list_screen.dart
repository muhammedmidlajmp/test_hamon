import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_hamon/domain/subject_model/subject_model.dart';
import 'package:test_hamon/presentation/provider/subject_provider/subject_list_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectssProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
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
          "Subject List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: subjectssProvider.fetchSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Subject> students = subjectssProvider.subjects;
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
                          "Teacher : ${students[index].teacher.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Credits : ${students[index].credits.toString()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
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
}
