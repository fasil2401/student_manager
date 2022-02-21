import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager/dbFunctions/functions.dart';
import 'package:student_manager/main.dart';
import 'package:student_manager/models/dbmodel.dart';
import 'package:student_manager/screens/create_student/widgets/sized_custom.dart';
import 'package:student_manager/screens/home/screen_home.dart';
import 'package:student_manager/screens/view_details/view_list.dart';

class EditDetails extends StatefulWidget {
  var box = Hive.box<DBModel>(boxName);
  final List<DBModel> student;
  final int index;
  EditDetails({Key? key, required this.student, required this.index})
      : super(key: key);

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  dynamic _path;
  int? newindex;
  int? newkey;
  int? accesskey;

  void preFilled() {
    _nameController.text = widget.student[widget.index].name;
    _ageController.text = widget.student[widget.index].age;
    _classController.text = widget.student[widget.index].std;
    _placeController.text = widget.student[widget.index].place;
    _path = widget.student[widget.index].path;
    newkey = widget.student[widget.index].key;
    List<DBModel> hello = widget.box.values.toList();
    for (int i = 0; i < hello.length; i++) {
      if (hello[i].key == newkey) {
        accesskey = i;
        break;
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  XFile? _image;

  Future getImage() async {
    final ImagePicker image = ImagePicker();
    _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _path = _image!.path;
      setState(() {});
    }
    return null;
  }

  @override
  void initState() {
    preFilled();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 187, 186),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBoxCustom(
                    custom: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _image == null
                              ? _path = Text('please upload photo')
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.file(
                                    File(_path),
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                //  uploadImage();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Choose Action'),
                                        content: SizedBox(
                                          height: 115,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.camera),
                                                title: Text('Camera'),
                                                onTap: () {
                                                  // uploadImageCamera();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.image),
                                                title: Text('Gallery'),
                                                onTap: () {
                                                  getImage();
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10)),
                              ),
                              icon: Icon(Icons.add_a_photo),
                              label: Text('Upload Photo'))
                        ],
                      ),
                    ),
                    height: 300),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBoxCustom(
                          custom: TextFormField(
                            controller: _nameController,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Name';
                              }
                              if (!RegExp(
                                      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid Name';
                              }
                              return null;
                            },
                          ),
                          height: 60),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBoxCustom(
                          custom: TextFormField(
                            controller: _ageController,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Age',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter age';
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Please enter a valid Age';
                              }
                              return null;
                            },
                          ),
                          height: 60),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBoxCustom(
                          custom: TextFormField(
                            controller: _classController,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Class',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Class';
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Please enter a valid Class';
                              }
                              return null;
                            },
                          ),
                          height: 60),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBoxCustom(
                          custom: TextFormField(
                            controller: _placeController,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Place',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Place';
                              }
                              if (!RegExp("[a-zA-Z]+").hasMatch(value)) {
                                return 'Please enter a valid Place';
                              }
                              return null;
                            },
                          ),
                          height: 60),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              onSubmitButton();
                              getAllStudents();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                            ),
                            icon: Icon(Icons.save_rounded),
                            label: Text('Save File')),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //

  void clearText() {
    _nameController.clear();
    _ageController.clear();
    _classController.clear();
    _placeController.clear();
  }

  void onSubmitButton() {
    // final path = image!.path;
    if (_formKey.currentState!.validate()) {
      // Box<DBModel> box = Hive.box('studentDb');
      print(_nameController.text);
      final _name = _nameController.text;
      final _age = _ageController.text;
      final _class = _classController.text;
      final _place = _placeController.text;
      if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _place.isEmpty) {
        return;
      }
      widget.box.putAt(
          accesskey!,
          DBModel(
              path: _path, name: _nameController.text, age: _ageController.text, std: _classController.text, place: _placeController.text));
              
      Navigator.of(context).pop();
    }
  }

  void snackBar(BuildContext ctx) {
    final snackBar = SnackBar(
      content: const Text('Added One'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}
