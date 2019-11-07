import 'package:flutter/material.dart';
import 'bottom_nav_bar_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: BottomNavBarController(),
    );
  }
}
