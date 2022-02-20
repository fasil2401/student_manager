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
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Student Management");
  String searchtext = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      appBar: BaseAppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (cusIcon.icon == Icons.search) {
                    cusIcon = const Icon(Icons.close);
                    cusSearchBar = TextField(
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
                            color: Colors.tealAccent,
                          )),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    setState(() {
                      searchtext = "";
                    });
                    cusIcon = const Icon(Icons.search);
                    cusSearchBar = const Text("Student Management");
                  }
                });
              },
              icon: cusIcon)
        ],
        title: cusSearchBar,
      ),
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






// import 'package:flutter/material.dart';
// import 'package:student_manager/screens/create_student/create.dart';
// import 'package:student_manager/screens/edit_details/edit.dart';
// import 'package:student_manager/screens/home/widgets/bottom_navigation.dart';
// import 'package:student_manager/screens/view_details/view_list.dart';

// class HomeScreen extends StatelessWidget {
  
//    HomeScreen({ Key? key}) : super(key: key);
//   static ValueNotifier<int>selectedIndexNotifier = ValueNotifier(0);
//   final pages = const[
//     ViewDetails(),
//     Create()
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 228, 224, 224),
//       appBar: AppBar(
//         title: Text('StudentManager'),
//         centerTitle: true,
//       ),
//       bottomNavigationBar:const StudentBottoNavigation(),
//       body: Container(
//         child: ValueListenableBuilder(valueListenable: selectedIndexNotifier,
//         builder: (BuildContext contex,int updatedIndex,_){
//           return pages[updatedIndex];
//         }),
//       ),
//     );
//   }
// }