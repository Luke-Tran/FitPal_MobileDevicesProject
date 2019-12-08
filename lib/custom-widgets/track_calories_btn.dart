import 'package:flutter/material.dart';

class TrackCaloriesBtn extends StatefulWidget {
  @override
  _TrackCaloriesBtnState createState() => _TrackCaloriesBtnState();
}

class _TrackCaloriesBtnState extends State<TrackCaloriesBtn> {
  Color btnColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          btnColor = Colors.grey[200];
        });
      },
      onTapUp: (tap) {
        Navigator.pushNamed(context, '/foodform');
        setState(() {
          btnColor = Colors.white;
        });
      },
      onTapCancel: () {
        setState(() {
          btnColor = Colors.white;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(color: Colors.black54),
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
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                 Text('0 / 2200 cal'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}