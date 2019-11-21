import 'package:flutter/material.dart';
import 'exercises.dart';
import 'database/db_model.dart';
import 'database/workout.dart';
import 'notifications.dart';
import 'workout_tile.dart';

class Workouts extends StatefulWidget {
  List<WorkoutTile> workoutTiles = [];
  bool isLoaded = false;

  Workouts({Key key}) : super(key: key);

  @override
  _WorkoutsState createState() => _WorkoutsState();

}

class _WorkoutsState extends State<Workouts> {
  var _notifications = Notifications();
	// test values 
	var exercise1 = new Exercises.exercise('push-ups', 15, 3);
	var exercise2 = new Exercises.exercise('sit-ups', 15, 3);
  var _lastInsertedId = 0;
  final _model = DBModel();
  Color addWorkoutColor = Colors.black54;

  Future<void> listWorkouts() async {
    List<Workout> workouts = await _model.getAllWorkouts();
    List<WorkoutTile> workoutTiles = [];
    for (Workout workout in workouts) {
      workoutTiles.add(WorkoutTile(workout: workout,));
    }
    widget.workoutTiles = workoutTiles;
    widget.isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoaded) listWorkouts();

    _notifications.init();
    double addBtnPadding = 14.0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget> [
            GestureDetector(
              onTapDown: (tap) {
                setState(() {
                  addWorkoutColor = Colors.black87;
                });
              },
              onTapUp: (tap) {
                _addWorkout(context);
                setState(() {
                  addWorkoutColor = Colors.black54;
                });
              },
              onTapCancel: () {
                setState(() {
                  addWorkoutColor = Colors.black54;
                });
              },
              child: Container(
                padding: EdgeInsets.all(addBtnPadding),
                decoration: BoxDecoration(
                  color:  addWorkoutColor,
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
            //exercise1.build(),
            //exercise2.build(),
            ListView.builder(
              itemCount: widget.workoutTiles.length,
              itemBuilder: (context, i) {
                return widget.workoutTiles[i];
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addWorkout(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/workoutform');
    if (event != null) {
      Workout newWorkout = event;
      print(newWorkout.toString());
      _notificationLater(event);
      _lastInsertedId = await _model.insertWorkout(event);
    }
  }

  Future<void> _notificationLater(Workout workout) async {
    //just made it send notifications now because no one has time to wait for a notification for days
    _notifications.sendNotificationNow('Workout Reminder', 'dont forget to complete your workout: '+workout.workout, 'payload');
    
    //this following line will be the correct line of code
    //await _notifications.sendNotificationLater('Workout Reminder', 'dont forget to complete your workout:'+workout.workout, workout.datetime, 'payload');
  }

}