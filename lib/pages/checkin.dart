import 'package:flutter/material.dart';
import 'package:mobile_devices_project/database/db_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_devices_project/custom-widgets/track_calories_btn.dart';
import 'package:mobile_devices_project/database/weight.dart';
import 'package:mobile_devices_project/globals.dart' as globals;

class Checkin extends StatefulWidget {

  Checkin({Key key}) : super(key: key);

  @override
  _CheckinState createState() => _CheckinState();

}

class _CheckinState extends State<Checkin> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckInWeight(),
    );
  }
}

//class for entering check-in weight
class CheckInWeight extends StatefulWidget {
	CheckInWeight({Key key}) : super(key: key);

	@override
	_CheckInWeightState createState() => _CheckInWeightState();
}

class _CheckInWeightState extends State<CheckInWeight> {
  final _formKey = GlobalKey<FormState>();
  final _model = DBModel();
	var _weight;
	String _progress;
	DateTime now = new DateTime.now();
	DateTime _currentDate;
  var _lastInsertedId = -1;

  Future<void> _insertWeight(double value) async {
    Weight newWeight = Weight(datetime: DateTime.now(), weight: value, user: globals.userEmail);
    _lastInsertedId = await _model.insertWeight(newWeight);
  }

  Future<void> _deleteWeight(int id) async {
    _model.deleteWeight(id);
  }

  Future<void> _listAllWeights() async {
    List<Map<String, dynamic>> weightList = await _model.getWeights();
    print('Weights:');
    for (Map<String, dynamic> weight in weightList) {
      print(weight);
    }
  }

	@override
	Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  // Text Field for user to put their weight in.
                  TextFormField (
                    validator: (value) => globals.isNumeric(value) ? null : 'Weight must be a number',
                    decoration: const InputDecoration(
                      hintText: 'Enter your current weight',
                      labelText: 'Enter weight',
                    ),
                    onSaved: (String value) {
                      print('Weight is $value');
                      // formats and displays the current date
                      // TODO: Format the date so it's easier to parse into a graph
                      print('Time is ${DateTime(now.day, now.month, now.year)}');
                      _weight = value;
                      _currentDate = DateTime(now.day, now.month, now.year);
                      _insertWeight(double.parse(value));
                    },
                  ),
                  // Formatting for the 'Check-In' button
                  Padding (
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton (
                      child: Text('Check-In'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // creates a snackbar when the check-in button is pressed
                          final snackBar = SnackBar (
                            content: Text('Weight Saved'),
                            action: SnackBarAction (
                              label: 'Undo',
                              onPressed: () {
                                _deleteWeight(_lastInsertedId);
                                print('weight deleted');
                              },
                            )
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                    )
                  ),
                  // Displays the drop down options for displaying the graph
                  DropdownButtonFormField (
                    decoration: const InputDecoration (
                      labelText: 'Graph Progress',
                    ),
                    value: _progress,
                    items: <String> ['1-Week', '1-Month', '6-Months', '1-Year']
                      .map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem<String> (
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        _progress = newValue;
                      });
                      print('Showing progress for $_progress');
                      // TODO: display graphs here
                      _listAllWeights();
                    },
                  ),
                ]
              )
            ),
            SizedBox(height: 50.0,),
            TrackCaloriesBtn(),
          ],
        ),
      ),
    );
	}
}
