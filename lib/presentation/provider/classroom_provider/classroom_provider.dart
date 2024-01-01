import 'package:flutter/material.dart';
import 'package:test_hamon/data/repository/repository.dart';
import 'package:test_hamon/domain/classroom_model/classroom_model.dart';
import 'package:test_hamon/domain/classroom_model/update_classroom_model.dart';

class ClassroomProvider extends ChangeNotifier {
  final Repository repository;

  ClassroomProvider(this.repository);

  List<Classroom> _classroom = [];
  List<Classroom> get classroom => _classroom;

  Future<void> fetchClassrooms() async {
    print('Fetching classrooms...');
    _classroom = await repository.getClassrooms();
    notifyListeners();
    print('classroom fetched successfully.');
  }

Future<bool> assignSubjectToClassroom(UpdateClassroomRequest request) async {
  try {
    await repository.patchClassroomSubject(request);

    await fetchClassrooms();
    notifyListeners();

    return true; // Indicate success
    
  } catch (error) {
    print('Error assigning subject to classroom: $error');
    // Handle the error as needed
    return false; // Indicate failure
  }
}


  Future<UpdateClassroomRequest> fetchIndividualClassroom(int id) async {
    try {
      notifyListeners();
      return await repository.fetchIndividualClassroom(id);
    } catch (error) {
      // Handle error
      print('Error in fetchIndividualClassroom: $error');
      rethrow;
    }
  }
}
