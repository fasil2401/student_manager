import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_manager/models/dbmodel.dart';
import 'package:student_manager/screens/edit_details/edit.dart';

class ShowDetails extends StatelessWidget {
  final DBModel student;

  ShowDetails({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _name = student.name;
    final _age = student.age;
    final _class = student.std;
    final _place = student.place;
    final _path = student.path;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 187, 186),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.file(
                  File(_path),
                  width: 260,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              
              const SizedBox(
                height: 20,
              ),
              Text(
                _name,
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Age : $_age',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Class : $_class',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Place : $_place',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
