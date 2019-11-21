import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'database/db_model.dart';
import 'database/workout.dart';
import 'dart:convert';


class WorkoutForm extends StatefulWidget {
  

  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final _formKey = GlobalKey<FormState>();
  String numReps = '''
  [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100]]
  ''';
  String numSets = '''
  [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]]
  ''';
  Color repsButtonColor = Colors.white;
  Color setsButtonColor = Colors.white;
  Color durationButtonColor = Colors.white;
  Color dateButtonColor = Colors.white;

  //placeholder info that will be updated from the workout page to add a workout to db
  DateTime _today = new DateTime.now();
  DateTime _datetime = new DateTime.now();
  int _day = 0; //not sure of the date role
  String _workout = 'placeholder workout';
  int _reps = 0;
  int _sets = 0;
  int _duration = 0;
  int _isCompleted = 0;
  double _caloriesBurned = 0.0;
  
  GestureDetector workoutFieldBtn(BuildContext context, String fieldName) {
    return GestureDetector(
      onTapDown: (tap) {
        _highlightPressedButton(fieldName);
      },
      onTapUp: (tap) {
        _showSelectedPicker(fieldName);
        _unpressAll();
      },
      onTapCancel: () {
        _unpressAll();
      },
      child: Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _getGestureDetectorColor(fieldName),
          border: Border.all(color: Colors.grey[200]),
        ),
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  fieldName,
                  textScaleFactor: 1.15,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  quantityLabel(fieldName),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
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
            onPressed: () {
              Navigator.of(context).pop(
                Workout(
                  datetime: _datetime,
                  day: _day,
                  workout: _workout,
                  reps: _reps,
                  sets: _sets,
                  duration: _duration,
                  isCompleted: _isCompleted,
                  caloriesBurned: _caloriesBurned,
                ),
              );
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
                    decoration: const InputDecoration(
                      labelText: 'Workout name',
                    ),
                    onChanged: (String newValue){
                      setState(() {
                        _workout = newValue;
                      });
                    },
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

                      //get the info from the repeat drop down list but not sure if this is needed? seems like extra work
                      onChanged: (String newValue){
                        setState(() {
                          //_day = newValue;
                        });
                      },
                  ),
                ],
              ),
            ),
          ),
          workoutFieldBtn(context, 'Reps'),
          SizedBox(height: 2.0),
          workoutFieldBtn(context, 'Sets'),
          SizedBox(height: 2.0),
          workoutFieldBtn(context, 'Duration'),
          SizedBox(height: 2.0),
          workoutFieldBtn(context, 'Due date'),
        ],
      ),
    );
  }
  
  void _highlightPressedButton(String fieldName) {
    switch(fieldName) {
      case 'Reps': {
        _pressRepsButton();
      }
      break;
      case 'Sets': {
        _pressSetsButton();
      }
      break;
      case 'Duration': {
        _pressDurationButton();
      }
      break;
      case 'Due date': {
        _pressDateButton();
      }
      break;
    }
  }

  void _pressRepsButton() {
    setState(() {
      repsButtonColor = Colors.grey[200];
      setsButtonColor = Colors.white;
      durationButtonColor = Colors.white;
      dateButtonColor = Colors.white;
    });
  }

  void _pressSetsButton() {
    setState(() {
      repsButtonColor = Colors.white;
      setsButtonColor = Colors.grey[200];
      durationButtonColor = Colors.white;
      dateButtonColor = Colors.white;
    });
  }

  void _pressDurationButton() {
    setState(() {
      repsButtonColor = Colors.white;
      setsButtonColor = Colors.white;
      durationButtonColor = Colors.grey[200];
      dateButtonColor = Colors.white;
    });
  }

  void _pressDateButton() {
    setState(() {
      repsButtonColor = Colors.white;
      setsButtonColor = Colors.white;
      durationButtonColor = Colors.white;
      dateButtonColor = Colors.grey[200];
    });
  }

  void _unpressAll() {
    setState(() {
      repsButtonColor = Colors.white;
      setsButtonColor = Colors.white;
      durationButtonColor = Colors.white;
      dateButtonColor = Colors.white;
    });
  }

  Color _getGestureDetectorColor(String fieldName) {
    switch(fieldName) {
      case 'Reps': {
        return repsButtonColor;
      }
      break;
      case 'Sets': {
        return setsButtonColor;
      }
      break;
      case 'Duration': {
        return durationButtonColor;
      }
      break;
      case 'Due date': {
        return dateButtonColor;
      }
      break;
    }
    return Colors.white;
  }

  void _showSelectedPicker(String fieldName) {
    switch(fieldName) {
      case 'Reps': {
        _repsPicker();
      }
      break;
      case 'Sets': {
        _setsPicker();
      }
      break;
      case 'Duration': {
        //todo add duration dropdown list
      }
      break;
      case 'Due date': {
        _selectDate(context);
      }
      break;
    }
  }
  
  void _repsPicker() {
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(numReps), isArray: true),
      hideHeader: true,
      onConfirm: (Picker picker, List value) {
        setState(() {
          _reps = int.parse(picker.adapter.text.substring(1,picker.adapter.text.length-1));
        });
      }
    ).showDialog(context);
  }

  void _setsPicker() {
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(numSets), isArray: true),
      hideHeader: true,
      onConfirm: (Picker picker, List value) {
        setState(() {
          _sets = int.parse(picker.adapter.text.substring(1,picker.adapter.text.length-1));
        });
      }
    ).showDialog(context);
  }

  //workout due date picker
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _datetime,
      firstDate: DateTime(_today.year, _today.month, _today.day),
      lastDate: _datetime.add(Duration(days: 365))
    );
    if (picked != null && picked != _datetime) {
      setState(() {
        _datetime = picked;
        print(_datetime);
      });
    }
  }

  Text quantityLabel(String fieldName) {
    String text = '';
    switch(fieldName) {
      case 'Reps': {
        text = '$_reps reps';
      }
      break;
      case 'Sets': {
        text = '$_sets sets';
      }
      break;
      case 'Duration': {
        text = '$_duration';
      }
      break;
      case 'Due date': {
        text = '${_datetime.year}-${_datetime.month}-${_datetime.day}';
      }
      break;
    }
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[600],
      ),
    );
  }
}