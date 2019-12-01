import 'package:flutter/material.dart';
import 'map.dart';


class Cardio extends StatefulWidget {

  Cardio({Key key}) : super(key: key);

  @override 
  _CardioState createState() => _CardioState();
}

class _CardioState extends State<Cardio> {

var _locationInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: Stack(
          children: <Widget> [
            Map(),
            Container(
              color: Colors.white,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Location',
                ),
                onChanged: (newValue){
                  _locationInput = newValue;
                  print('${_locationInput}');
                },
              ),
             ),
          ]
        ),
    );
  }
}