import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'database/db_model.dart';
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
  
  GestureDetector workoutFieldBtn(BuildContext context, String fieldName) {
    return GestureDetector(
      onTap: () {
        switch(fieldName) {
          case 'Reps': {
            Picker(
              adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(numReps), isArray: true),
              hideHeader: true,
              onConfirm: (Picker picker, List value) {
                //print(value.toString());
                print(picker.adapter.text);
              }
            ).showDialog(context);
          }
          break;
          case 'Sets': {
            Picker(
              adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(numSets), isArray: true),
              hideHeader: true,
              onConfirm: (Picker picker, List value) {
                //print(value.toString());
                print(picker.adapter.text);
              }
            ).showDialog(context);
          }
          break;
          case 'Duration': {

          }
          break;
          case 'Due date': {
            DateTime today = DateTime.now();
            Future<DateTime> selectedDate = showDatePicker(
              context: context,
              initialDate: today,
              firstDate: today,
              lastDate: today.add(Duration(days: 365)),
            );
          }
          break;
        }
      },
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
}