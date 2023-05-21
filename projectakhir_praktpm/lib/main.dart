import 'package:flutter/material.dart';
import 'package:projectakhir_praktpm/dashboard.dart';
import 'package:projectakhir_praktpm/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valorant App',
      home: LoginScreen(),
    );
  }
}