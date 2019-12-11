import 'package:flutter/material.dart';
//import 'package:flutter_picker/flutter_picker.dart';
import 'package:mobile_devices_project/database/workout.dart';
//import 'dart:convert';
import 'package:mobile_devices_project/custom-widgets/workout_field_btn.dart';
import 'package:mobile_devices_project/globals.dart' as globals;

class WorkoutForm extends StatefulWidget {
  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final _formKey = GlobalKey<FormState>();
  WorkoutFieldBtn _repsBtn = WorkoutFieldBtn(fieldName: 'Reps');
  WorkoutFieldBtn _setsBtn = WorkoutFieldBtn(fieldName: 'Sets');
  WorkoutFieldBtn _durationBtn = WorkoutFieldBtn(fieldName: 'Duration');
  WorkoutFieldBtn _dueDateBtn = WorkoutFieldBtn(fieldName: 'Due date');
  String _workoutName = '';
  String _repeatText;
  int _repeatEvery = 0;

  @override
  Widget build(BuildContext context) {
    globals.isWorkoutsLoaded = false;
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
            onPressed: () {
              if (_formKey.currentState.validate()) { 
                Navigator.of(context).pop(
                  [
                    Workout(
                      datetime: _dueDateBtn.datetime,
                      repeatEvery: _repeatEvery,
                      workoutName: _workoutName,
                      reps: _repsBtn.reps,
                      sets: _setsBtn.sets,
                      duration: _durationBtn.duration,
                      isCompleted: 0,
                      user: globals.userEmail, 
                    ),
                    'add'
                  ],
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) => (value != '' && value != null) ? null : 'Please name the exercise',
                    decoration: const InputDecoration(
                      labelText: 'Workout name',
                    ),
                    onChanged: (String newValue){
                      setState(() {
                        _workoutName = newValue;
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration (
                      labelText: 'Repeat every...',
                    ),
                    value: _repeatText,
                    items: <String> ['Never repeat', 'Every day', 'Every week', 'Every month']
                      .map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem<String> (
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    onChanged: (String newValue) {
                      switch(newValue) {
                        case 'Every day': {
                          _repeatEvery = 1;
                        }
                        break;
                        case 'Every week': {
                          _repeatEvery = 7;
                        }
                        break;
                        case 'Every month': {
                          _repeatEvery = 30;
                        }
                        break;
                        default: {
                          _repeatEvery = 0;
                        }
                        break;
                      }
                      setState(() {
                        _repeatText = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          _repsBtn,
          SizedBox(height: 2.0),
          _setsBtn,
          SizedBox(height: 2.0),
          _durationBtn,
          SizedBox(height: 2.0),
          _dueDateBtn,
        ],
      ),
    );
  }
}