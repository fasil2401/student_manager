import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_manager/models/dbmodel.dart';
import 'package:student_manager/screens/splash_screen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(GenderAdapter().typeId)) {
    Hive.registerAdapter(GenderAdapter());
  }

  if (!Hive.isAdapterRegistered(DBModelAdapter().typeId)) {
    Hive.registerAdapter(DBModelAdapter());
  }
  Hive.openBox<DBModel>('studentDb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const splash_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
