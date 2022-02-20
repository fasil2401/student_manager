import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_manager/models/dbmodel.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier =ValueNotifier([]);
ValueNotifier<List<DBModel>> studentListNotifier = ValueNotifier([]);

Future<void> insertData(DBModel value) async {
  final _mainDb = await Hive.openBox<DBModel>('StudentDb');
  // final _id =
  value.id = await _mainDb.add(value);

  studentListNotifier.value.add(value);
}

Future<List<DBModel>> getData() async {
  final _mainDb = await Hive.openBox<DBModel>('StudentDb');
  return _mainDb.values.toList();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<DBModel>('studentDb');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}
// Future<void>deleteStudentData(int id) async{
// final studentDB = await Hive.openBox<DBModel>('studentDb');
// await studentDB.delete(id);

// getAllStudents();
// }
