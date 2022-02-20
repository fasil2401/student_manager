import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_manager/screens/home/screen_home.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 226, 114),
      body: Center(
        child: Image.asset(
          'assets/images/pngwing.com.png',
          height: 200,
        ),
      ),
    );
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}
