import 'package:flutter/material.dart';
import 'database/workout.dart';

class WorkoutTile extends StatefulWidget {
  Workout workout;

  WorkoutTile({this.workout});

  @override
  _WorkoutTileState createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: implement a way to edit workout data
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (bool) {
              //TODO: delete the workout
              setState(() { checked = !checked; });
            },
            value: checked,
          ),
          Column(
            children: <Widget>[
              Text(widget.workout.workout),
            ],
          ),
        ],
      ),
    );
  }
}