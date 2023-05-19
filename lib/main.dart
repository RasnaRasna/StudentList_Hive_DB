import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weak_five_studentlist_main/screens/home_screens.dart';

import 'db/model/data_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students List',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ScreenHome(),
    );
  }
}
