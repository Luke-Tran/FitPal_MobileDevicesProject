import 'package:flutter/material.dart';
import 'database/db_model.dart';

class WorkoutForm extends StatefulWidget {
  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final _formKey = GlobalKey<FormState>();

  GestureDetector workoutFieldBtn(String fieldName) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Text(fieldName),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a workout...'),
        backgroundColor: Colors.black54,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Workout name',
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration (
                      labelText: 'Repeat every...',
                    ),
                    items: <String> ['Never repeat', 'Every day', 'Every week', 'Every month']
                      .map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem<String> (
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                  ),
                ],
              ),
            ),
          ),
          workoutFieldBtn('Reps'),
          SizedBox(height: 2.0),
          workoutFieldBtn('Sets'),
          SizedBox(height: 2.0),
          workoutFieldBtn('Duration'),
          SizedBox(height: 2.0),
          workoutFieldBtn('Due date'),
        ],
      ),
    );
  }
}