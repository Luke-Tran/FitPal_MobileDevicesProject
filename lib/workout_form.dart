import 'package:flutter/material.dart';
import 'database/db_model.dart';

class WorkoutForm extends StatefulWidget {
  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a workout...'),
        backgroundColor: Colors.black54,
      ),
    );
  }
}