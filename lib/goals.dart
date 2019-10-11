import 'package:flutter/material.dart';
import 'navigation_app_bar.dart';

class Goals extends StatefulWidget {
  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: Text('Goals'),
    );
  }
}