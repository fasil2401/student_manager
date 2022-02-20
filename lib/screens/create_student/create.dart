import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager/dbFunctions/functions.dart';
import 'package:student_manager/screens/create_student/widgets/sized_custom.dart';
import 'package:student_manager/models/dbmodel.dart';
import 'package:student_manager/screens/home/screen_home.dart';
import 'package:student_manager/screens/view_details/view_list.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _placeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  dynamic _imagePath;

  Future getImage() async {
    final ImagePicker image = ImagePicker();
    _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _imagePath = _image!.path;
      setState(() {});
    }
    return null;
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
                              ? _imagePath = Text('data')
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.file(
                                    File(_imagePath),
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
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black),
                              padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20,vertical: 10)),),
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
                              //  File? _images = image;
                              onSubmitButton();
                            },
                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black),
                              padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20,vertical: 10)),),
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

  void clearText() {
    _nameController.clear();
    _ageController.clear();
    _classController.clear();
    _placeController.clear();
  }

  Future<void> onSubmitButton() async {
    if (_formKey.currentState!.validate()) {
      final _name = _nameController.text;
      final _age = _ageController.text;
      final _class = _classController.text;
      final _place = _placeController.text;
      if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _place.isEmpty) {
        return;
      }
      snackBar(context);
      final _student = DBModel(
          name: _name, age: _age, std: _class, place: _place, path: _imagePath);
      insertData(_student);
      clearText();
    }
  }

  void snackBar(BuildContext ctx) {
    final snackBar = SnackBar(
      content: const Text('Added One'),
      action: SnackBarAction(
        label: 'Go',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomeScreen()));
        },
      ),
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}
