// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';

// class SaveImage extends StatefulWidget {
//   const SaveImage({ Key? key }) : super(key: key);

//   @override
//   _SaveImageState createState() => _SaveImageState();
// }

// class _SaveImageState extends State<SaveImage> {

// File? image;
// uploadImageGalery() async{
//   var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//   setState(() {
//     image = File(pickedImage!.path);
//   });
// }
// uploadImageCamera() async{
//   var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//   setState(() {
//     image = File(pickedImage!.path);
//   });
// }

// Widget imageGallery(){
//   return FutureBuilder<File>(
//     future: image,
//     builder: builder);
// }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }