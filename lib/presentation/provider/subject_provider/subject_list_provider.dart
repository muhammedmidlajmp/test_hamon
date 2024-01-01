import 'package:flutter/material.dart';
import 'package:test_hamon/data/repository/repository.dart';
import 'package:test_hamon/domain/subject_model/subject_model.dart';

class SubjectsProvider extends ChangeNotifier {
  final Repository repository;

  SubjectsProvider(this.repository);

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  Future<void> fetchSubjects() async {
    print('Fetching Subjects...');
    _subjects = await repository.getSubjects();
    notifyListeners();
    print('Subjects fetched successfully.');
  }
}
