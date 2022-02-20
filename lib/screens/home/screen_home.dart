import 'package:flutter/material.dart';
import 'package:student_manager/screens/create_student/create.dart';
import 'package:student_manager/screens/edit_details/edit.dart';
import 'package:student_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:student_manager/screens/view_details/baseAppBar.dart';
import 'package:student_manager/screens/view_details/view_list.dart';

class HomeScreen extends StatefulWidget {
  
   HomeScreen({ Key? key}) : super(key: key);
  static ValueNotifier<int>selectedIndexNotifier = ValueNotifier(0);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = const[
    ViewDetails(),
    Create()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      
      bottomNavigationBar:const StudentBottoNavigation(),
      body: Container(
        child: ValueListenableBuilder(valueListenable: HomeScreen.selectedIndexNotifier,
        builder: (BuildContext contex,int updatedIndex,_){
          return pages[updatedIndex];
        }),
      ),
    );
  }
}

