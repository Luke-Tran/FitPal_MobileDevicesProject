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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.workout.workout,
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
                      padding: EdgeInsets.fromLTRB(2.0, 2.0, 10.0, 2.0),
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
    );
  }
}