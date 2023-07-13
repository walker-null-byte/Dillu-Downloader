import 'package:flutter/material.dart';
import 'Home.dart';
import 'downloadVideo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Get storage permission if not already available
  @override
  Widget build(BuildContext context) {
    getPermission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}