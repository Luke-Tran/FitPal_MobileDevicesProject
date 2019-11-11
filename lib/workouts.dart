import 'package:flutter/material.dart';
import 'exercises.dart';
import 'database/db_model.dart';
import 'database/workout.dart';

class Workouts extends StatefulWidget {

  Workouts({Key key}) : super(key: key);

  @override
  _WorkoutsState createState() => _WorkoutsState();

}

class _WorkoutsState extends State<Workouts> {
  //var _notifications = Notifications();
	// test values 
	var exercise1 = new Exercises.exercise('push-ups', 15, 3);
	var exercise2 = new Exercises.exercise('sit-ups', 15, 3);
  var _lastInsertedId = 0;
  final _workout = DBModel();

  ///@override
  Widget build(BuildContext context) {
    //_notifications.init();
    double addBtnPadding = 14.0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          // test output
          children: <Widget> [
            GestureDetector(
              onTap: () {
                _addWorkout(context);
              },
              child: Container(
                padding: EdgeInsets.all(addBtnPadding),
                decoration: BoxDecoration(
                  color:  Colors.black54,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(width: addBtnPadding),
                    Text(
                      'Add a workout...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            exercise1.build(),
            exercise2.build(),
          ]
        ),
      ),
    );
  }

  Future<void> _addWorkout(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/workoutform');
    _notificationLater(event);
    _lastInsertedId = await _workout.insertWorkout(event);
  }

  Future<void> _notificationLater(Workout workout) async {
    //await _notifications.sendNotificationLater('Workout Reminder', 'dont forget to complete your workout:'+workout.workout, workout.datetime, 'payload');
  }

}