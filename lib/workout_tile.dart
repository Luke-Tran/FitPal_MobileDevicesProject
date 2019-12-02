import 'package:flutter/material.dart';
import 'database/workout.dart';
import 'database/db_model.dart';
import 'workouts.dart';
import 'globals.dart' as globals;

class WorkoutTile extends StatefulWidget {
  Workout workout;
  Workouts workoutsPage;

  WorkoutTile({this.workout, this.workoutsPage});

  @override
  _WorkoutTileState createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  bool checked = false;
  Color tileColor = Colors.white;
  final _model = DBModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          tileColor = Colors.grey[200];
        });
      },
      onTapUp: (tap) {
        //TODO: implement a way to edit workout data
        setState(() {
          tileColor = Colors.white;
        });
      },
      onTapCancel: () {
        setState(() {
          tileColor = Colors.white;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 10.0),
        decoration: BoxDecoration(
          color: tileColor,
          border: Border.all(color: Colors.grey[200]),
        ),
        child: Row(
          children: <Widget>[
            Checkbox(
              onChanged: (bool) async {
                setState(() { checked = !checked; });
                await Future.delayed(const Duration(milliseconds: 300), () {});
                if (checked) {
                  setState(() { checked = false; });
                  await Future.delayed(const Duration(milliseconds: 30), () {});
                  await _model.deleteWorkout(widget.workout.workoutID);
                  widget.workoutsPage.workoutsPageState.setState(() { 
                    globals.isWorkoutsLoaded = false;
                  });
                }
              },
              value: checked,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.workout.workoutName,
                  textScaleFactor: 1.2,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: Text('${widget.workout.datetime.year}-${widget.workout.datetime.month}-${widget.workout.datetime.day}'),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Reps'),
                      ),
                      Text(
                        '${widget.workout.reps}',
                        textScaleFactor: 1.2,
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Sets'),
                      ),
                      Text(
                        '${widget.workout.sets}',
                        textScaleFactor: 1.2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}