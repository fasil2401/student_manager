import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_manager/dbFunctions/functions.dart';
import 'package:student_manager/screens/edit_details/edit.dart';
import 'package:student_manager/screens/show_details/show_details.dart';
import 'package:student_manager/models/dbmodel.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext ctx, List<DBModel> studentList, Widget? child) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return Card(
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ShowDetails(
                              student: data,
                            )));
                  },
                  leading: CircleAvatar(
                      child: ClipOval(
                          child: Image.file(
                    File(data.path),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ))),
                  title: Text(data.name),
                  subtitle: Text(data.age),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => EditDetails(
                                    student: data,
                                    index: index,
                                  )));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 223, 130, 9),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          data.delete();
                          getAllStudents();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: studentList.length);
      },
    );
  }
}
