import 'package:flutter/material.dart';
import 'exercises.dart';

class Workouts extends StatefulWidget {

  Workouts({Key key}) : super(key: key);

  @override
  _WorkoutsState createState() => _WorkoutsState();

}

class _WorkoutsState extends State<Workouts> {

	// test values 
	var exercise1 = new Exercises.exercise('push-ups', 15, 3);
	var exercise2 = new Exercises.exercise('sit-ups', 15, 3);

  Widget build(BuildContext context) {
    double addBtnPadding = 14.0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          // test output
          children: <Widget> [
            GestureDetector(
              onTap: () {
                //TODO: pushNamed a form page to enter exercise
                Navigator.pushNamed(context, '/workoutform');
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
}