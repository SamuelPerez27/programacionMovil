import 'package:flutter/material.dart';
import 'package:proyectofinal/firebase_options.dart';
import 'package:proyectofinal/pages/home_page_inicio.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  Hive.init("pages/home_page_inicio.dart");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageInicio(), // Usa HomePageInicio como la pantalla principal
    );
  }
}
