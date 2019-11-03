import 'package:flutter/material.dart';
import 'navigation_app_bar.dart';
import 'exercises.dart';

class Workouts extends StatefulWidget {
  @override
  _WorkoutsState createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {

	// test values 
	var exercise1 = new Exercises.exercise('push-ups', 15, 3);
	var exercise2 = new Exercises.exercise('sit-ups', 15, 3);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: ListView(
      	// test output
      	children: <Widget> [
      	exercise1.build(),
      	exercise2.build(),])
    );
  }
}