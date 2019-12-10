import 'package:flutter/material.dart';
import 'package:mobile_devices_project/database/workout.dart';

class WorkoutInfoDialog extends StatelessWidget {
  Workout workout;
  WorkoutInfoDialog(this.workout);

  Text _getRepeatText(Workout workout) {

    if (workout.repeatEvery <= 0) {
      return Text('Never repeat');
    }
    else {
      return Text('Repeat every ${workout.repeatEvery} days');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            workout.workoutName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          _getRepeatText(workout),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () { Navigator.pop(context, 'delete'); },
                child: Text('Delete'),
              ),
              FlatButton(
                onPressed: () { Navigator.pop(context, 'completed'); },
                child: Text('Completed'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}