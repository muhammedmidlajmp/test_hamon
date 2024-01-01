import 'package:flutter/material.dart';
import 'package:test_hamon/data/repository/repository.dart';
import 'package:test_hamon/domain/student_model/student_model.dart';
import 'package:test_hamon/domain/student_register_model/student_register_model.dart';

class StudentsProvider extends ChangeNotifier {
  final Repository repository;

  StudentsProvider(this.repository);

  List<Student> _students = [];
  List<Student> get students => _students;
  List<Registration> _register = [];

  List<Registration> get register => _register;

  Future<void> fetchStudents() async {
    print('Fetching students...');
    _students = await repository.getStudents();
    notifyListeners();
    print('Students fetched successfully.');
  }

  Future<bool> assignSubjectToStudent(
      {required subject, required student}) async {
    try {
      await repository.postRegister(student: student, subject: subject);
      notifyListeners();
      // Refresh the classrooms list after the assignment

      return true;
    } catch (error) {
      print('Error assigning subject to classroom: $error');
      // Handle the error as needed
      return false;
    }
  }

  Future<void> fetchRegister() async {
    print('Fetching students...');
    _register = await repository.getRegisterdata();
    notifyListeners();
    print('Students fetched successfully.');
  }

  Future<void> deleteRegister(int rgstrId) async {
    print('Fetching students...');
    // Note: No need to update _register locally here

    // Make sure to fetch the updated list after deletion
    await repository.deleteRegister(rgstrId);
    await fetchRegister();

    // Notify listeners after the update
    notifyListeners();

    print('Registration deleted successfully.');
  }
}
