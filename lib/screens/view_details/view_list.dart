import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_manager/dbFunctions/functions.dart';
import 'package:student_manager/screens/edit_details/edit.dart';
import 'package:student_manager/screens/show_details/show_details.dart';
import 'package:student_manager/models/dbmodel.dart';

import 'baseAppBar.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({Key? key}) : super(key: key);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = const Text("Student Management",style: TextStyle(fontSize: 28),);
  String searchtext = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 187, 186),
      appBar: BaseAppBar(
        
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (cusIcon.icon == Icons.search) {
                    cusIcon = const Icon(Icons.close);
                    cusSearchBar = TextField(
                      autofocus: true,
                      onChanged: (value) {
                        searchtext = value;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent)),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 236, 238, 238),
                          )),
                      style: const TextStyle(color: Color.fromARGB(255, 236, 236, 236), fontSize: 25),
                    );
                  } else {
                    setState(() {
                      searchtext = "";
                    });
                    cusIcon = const Icon(Icons.search);
                    cusSearchBar = const Text("Student Management",style: TextStyle(fontSize: 25));
                  }
                });
              },
              icon: cusIcon)
        ],
        title: cusSearchBar,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DBModel>('studentDb').listenable(),
        builder: (context, Box<DBModel> newbox, _) {
          List key = newbox.keys.toList();
          if (key.isEmpty) {
            return const Center(
              child: Text("The Student List is Empty"),
            );
          } else {
            List<DBModel>  data = newbox.values
                .toList()
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchtext.toLowerCase())).toList();
             if(data.isEmpty){
               return const Center(
                   child: Text("No results found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),));
            }return Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        tileColor: Color.fromARGB(255, 231, 231, 231),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ShowDetails(
                                student: data[index],
                              )));
                        },
                        leading: data[index].path == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: const Text(
                                  "No Image",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.tealAccent),
                                ),
                              )
                            : CircleAvatar(
                                child: ClipOval(
                                    child: Image.file(
                                File(data[index].path),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ))),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => EditDetails(
                                      student: data,
                                      index: index,
                                    )));
                              },
                              child: const Icon(Icons.edit,color: Color.fromARGB(255, 165, 162, 9)),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete"),
                                        content:
                                        const  Text("Do you want to delete it?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                data[index].delete();
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Student deleted Successfully")));
                                              },
                                              child:const  Text("Yes"))
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(Icons.delete,color: Color.fromARGB(255, 240, 116, 116),),
                            ),
                          ],
                        ),
                        title: Text(
                          data[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue[50],
                    );
                  },
                  itemCount: data.length),
            );
          }
        },
      ),
     
    );
  }
}