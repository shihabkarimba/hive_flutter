import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_practice/addStudent/dataModel.dart';


ValueNotifier<List<StudentModel>> StudentListNotifier = ValueNotifier([]);

addStudent(StudentModel value) async {
  //StudentListNotifier.value.add(value);
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  await studentDB.add(value);
  // value.id = _id;

  StudentListNotifier.value.add(value);
  StudentListNotifier.notifyListeners();
}

getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  StudentListNotifier.value.clear();

  StudentListNotifier.value.addAll(studentDB.values);
  StudentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  await studentDB.deleteAt(id);
  getAllStudents();
}

Future<void> updateStudent(int index,StudentModel updateStudent) async{
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  await studentDB.put(index, updateStudent);
  getAllStudents();
}