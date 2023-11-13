import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentsService extends ChangeNotifier {
  final String _baseUrl = "testapi-ea3c4-default-rtdb.firebaseio.com";

  late Student selectedStudent;

  List<Student> students = [];

  bool isLoading = false;
  bool isSaving = false;

  StudentsService() {
    loadStudents();
  }

  Future<List<Student>> loadStudents() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'students.json');
    final resp = await http.get(url);

    final Map<String, dynamic> studentsMap = json.decode(resp.body);
    print(studentsMap);

    studentsMap.forEach((key, value) {
      Student tempStudent = Student.fromJson(value);
      tempStudent.id = key;
      students.add(tempStudent);
    });

    isLoading = false;
    notifyListeners();
    print("hello ${this.students}");
    return students;
  }

  Future createOrUpdate(Student student) async {
    isSaving = true;

    if (student.id == null) {
      await createStudent(student);
    } else {
      await updateStudent(student);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createStudent(Student student) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'students.json');
    final resp = await http.post(url, body: student.toJson());

    final decodedData = json.decode(resp.body);

    student.id = decodedData['name'];

    students.add(student);

    return student.id!;
  }

  Future<String> updateStudent(Student student) async {
    isSaving = true;
    // final url = Uri.https(_baseUrl, 'students.json');
    // final resp = await http.put(url, body: student.toJson());

    // final decodedData = json.decode(resp.body);

    // final index = students.indexWhere((element) => element.id == student.id);

    // students[index] = student;

    return student.id!;
  }

  Future<String> deleteStudentById(String id) async {
    // isLoading = true;
    // final url = Uri.https(_baseUrl, 'students.json');
    // final resp = await http.delete(url, body: {"name": id});

    // final decodedData = json.decode(resp.body);

    // loadStudents();
    return id;
  }
}
