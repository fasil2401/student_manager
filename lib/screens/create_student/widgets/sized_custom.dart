import 'package:flutter/material.dart';
import 'package:student_manager/screens/home/screen_home.dart';

class SizedBoxCustom extends StatelessWidget {
  final Widget custom;
  final double height;
  const SizedBoxCustom({Key? key, required this.custom, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(child: custom),
    );
  }
}
