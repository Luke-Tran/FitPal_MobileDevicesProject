import 'package:flutter/material.dart';

// This is a StatefulWidget because the number of calories can change
class TrackCaloriesBtn extends StatefulWidget {
  @override
  _TrackCaloriesBtnState createState() => _TrackCaloriesBtnState();
}

class _TrackCaloriesBtnState extends State<TrackCaloriesBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline, 
                  color: Colors.yellow[700],
                ),
                SizedBox(width: 3.0,),
                Text('Track calories'),
              ],
            ),
            SizedBox(height: 5.0,),
            Row(
              children: <Widget>[
                 Text('0 / 0 Kcal'),
              ],
            ),
          ],
        ),
      ),
    );
    
    
  }
}