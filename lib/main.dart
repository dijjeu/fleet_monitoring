import 'package:fleet_monitoring/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fleet Monitoring App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Login(),
    );
  }
}