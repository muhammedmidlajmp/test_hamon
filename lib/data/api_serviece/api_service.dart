import 'package:test_hamon/constants/api_constants.dart';
import 'package:test_hamon/domain/classroom_model/classroom_model.dart';
import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';
import 'package:test_hamon/domain/student_model/student_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_hamon/domain/student_register_model/student_register_model.dart';
import 'package:test_hamon/domain/subject_model/subject_model.dart';

class ApiService {
  final String baseUrl;
  ApiConstants apiConstants = ApiConstants();

  ApiService(this.baseUrl);

  Future<List<Student>> getStudents() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nibrahim.pythonanywhere.com/students/?api_key=fcd06'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['students'];
        return data
            .map((studentJson) => Student.fromJson(studentJson))
            .toList();
      } else {
        throw Exception(
            'Failed to load students - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching students: $error');
      rethrow; // Rethrow the exception after handling if needed
    }
  }

  Future<List<Subject>> getSubjects() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nibrahim.pythonanywhere.com/subjects/?api_key=fcd06'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['subjects'];
        return data
            .map((subjectJson) => Subject.fromJson(subjectJson))
            .toList();
      } else {
        throw Exception(
            'Failed to load subjects - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching subjects: $error');
      rethrow; // Rethrow the exception after handling if needed
    }
  }

  Future<List<Classroom>> getClassrooms() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nibrahim.pythonanywhere.com/classrooms/?api_key=fcd06'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['classrooms'];
        return data
            .map((classroomJson) => Classroom.fromJson(classroomJson))
            .toList();
      } else {
        throw Exception(
            'Failed to load classrooms - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching classrooms: $error');
      rethrow; // Rethrow the exception after handling if needed
    }
  }

  Future<http.Response> patchClassroomSubject(
      UpdateClassroomRequest request) async {
    try {
      // Create a MultipartRequest
      final Uri url = Uri.parse(
          'http://nibrahim.pythonanywhere.com/classrooms/${request.id}?api_key=fcd06');
      final http.MultipartRequest httpRequest =
          http.MultipartRequest('PATCH', url);

      // Add fields to the request
      httpRequest.fields['subject'] = request.subject.toString();

      // Send the request and get the response
      final http.StreamedResponse response = await httpRequest.send();

      // Check the status code
      if (response.statusCode == 200) {
        // Successful PATCH request (OK)

        print(await response.stream.bytesToString());
      } else if (response.statusCode == 404) {
        // Classroom not found (Not Found)

        print('Classroom not found');
      } else {
        // Handle other status codes as needed
        print(
            'Failed to patch classroom subject. Status code: ${response.statusCode}');
      }

      // Convert StreamedResponse to a regular Response
      final http.Response regularResponse =
          await http.Response.fromStream(response);
      return regularResponse;
    } catch (error) {
      print('Error patching classroom subject: $error');
      rethrow;
    }
  }

  Future<UpdateClassroomRequest> getIndividualClassroom(int classroomId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://nibrahim.pythonanywhere.com/classrooms/$classroomId?api_key=fcd06'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return UpdateClassroomRequest.fromJson(data);
      } else {
        throw Exception(
            'Failed to get classroom - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching classroom: $error');
      rethrow; // Rethrow the exception after handling if needed
    }
  }

  Future<void> postRegistration(
      {required int student, required int subject}) async {
    const String url =
        'http://nibrahim.pythonanywhere.com/registration?api_key=fcd06';

    try {
      final Map<String, dynamic> postData = {
        'student': student,
        'subject': subject
      };

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error registering: $error');
      // Handle the error appropriately
    }
  }

  Future<List<Registration>> getRegistration() async {
    const String url = 'http://nibrahim.pythonanywhere.com/registration';
    const String apiKey = 'fcd06';

    try {
      final Uri uri = Uri.parse('$url?api_key=$apiKey');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse =
            json.decode(response.body)['registrations'];
        return jsonResponse
            .map((registrationJson) => Registration.fromJson(registrationJson))
            .toList();
      } else {
        print(
            'Failed to fetch registration. Status code: ${response.statusCode}');
        print(response.reasonPhrase);
        throw Exception('Failed to fetch registration');
      }
    } catch (error) {
      print('Error fetching registration: $error');
      throw error;
    }
  }

  Future<void> deleteRegistration(int registrationId) async {
    final String url =
        'http://nibrahim.pythonanywhere.com/registration/$registrationId';
    final String apiKey = 'fcd06';

    try {
      final Uri uri = Uri.parse('$url?api_key=$apiKey');
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        print('Registration deleted successfully');
      } else {
        print(
            'Failed to delete registration. Status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error deleting registration: $error');
      // Handle the error appropriately
    }
  }
}
