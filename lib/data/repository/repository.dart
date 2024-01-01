import 'package:http/http.dart' as http;
import 'package:test_hamon/data/api_serviece/api_service.dart';
import 'package:test_hamon/domain/classroom_model/classroom_model.dart';
import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';
import 'package:test_hamon/domain/student_model/student_model.dart';
import 'package:test_hamon/domain/student_register_model/student_register_model.dart';
import 'package:test_hamon/domain/subject_model/subject_model.dart';

class Repository {
  final ApiService apiService;

  Repository(this.apiService);

  Future<List<Student>> getStudents() async {
    try {
      final List<Student> students = await apiService.getStudents();
      print(students.first.email);
      return students;
    } catch (error) {
      // Handle the error or rethrow it if needed
      print('Error in Repository - getStudents: $error');
      rethrow;
    }
  }

  Future<List<Subject>> getSubjects() async {
    try {
      final List<Subject> subjects = await apiService.getSubjects();
      print(subjects.first.name);
      return subjects;
    } catch (error) {
      // Handle the error or rethrow it if needed
      print('Error in Repository - getSubjects: $error');
      rethrow;
    }
  }

  Future<List<Classroom>> getClassrooms() async {
    try {
      final List<Classroom> classroom = await apiService.getClassrooms();
      print(classroom.first.name);
      return classroom;
    } catch (error) {
      // Handle the error or rethrow it if needed
      print('Error in Repository - getClassrooms: $error');
      rethrow;
    }
  }

  Future<http.Response> patchClassroomSubject(
      UpdateClassroomRequest request) async {
    return await apiService.patchClassroomSubject(request);
  }

  Future<UpdateClassroomRequest> fetchIndividualClassroom(int id) async {
    try {
      return await apiService.getIndividualClassroom(id);
    } catch (error) {
      // Handle error or rethrow if needed
      print('Error fetching individual classroom: $error');
      rethrow;
    }
  }

  Future<void> postRegister({required subject, required student}) async {
    await apiService.postRegistration(student: student, subject: subject);
  }
  
  Future<List<Registration>> getRegisterdata() async {
    try {
      final List<Registration> register = await apiService.getRegistration();
      print(register.first.id);
      return register;
    } catch (error) {
      // Handle the error or rethrow it if needed
      print('Error in Repository - getStudents: $error');
      rethrow;
    }
  }

  Future<void> deleteRegister(int regtrId) async {
    return await apiService.deleteRegistration(regtrId);
  }
}
