import 'package:flutter/material.dart';
import 'package:student_manager/screens/home/screen_home.dart';

class StudentBottoNavigation extends StatelessWidget {



  const StudentBottoNavigation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier ,
      builder: (BuildContext ctx, int updatedIndex, Widget?_){
        return BottomNavigationBar(
        currentIndex: updatedIndex,
        onTap: (newIndex){
          HomeScreen.selectedIndexNotifier.value = newIndex;
        } ,
        items: 
      [
        BottomNavigationBarItem(icon: Icon(Icons.home),
      label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.category),
      label: 'Add')
      ]
      
      );
      },
    );
  }
}