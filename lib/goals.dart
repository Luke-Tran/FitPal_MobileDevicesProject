import 'package:flutter/material.dart';

class Goals extends StatefulWidget {

  Goals({Key key}) : super(key: key);

  @override
  _GoalsState createState() => _GoalsState();

}

class _GoalsState extends State<Goals> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Goals'),
    );
  }
}