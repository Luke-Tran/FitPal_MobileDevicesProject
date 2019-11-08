import 'package:flutter/material.dart';
import 'exercises.dart';

class Workouts extends StatefulWidget {

  Workouts({Key key}) : super(key: key);

  @override
  _WorkoutsState createState() => _WorkoutsState();

}

class _WorkoutsState extends State<Workouts> {

	// test values 
	var exercise1 = new Exercises.exercise('push-ups', 15, 3);
	var exercise2 = new Exercises.exercise('sit-ups', 15, 3);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          // test output
          children: <Widget> [
          exercise1.build(),
          exercise2.build(),
        ]),
      ),
    );
  }
}