import 'package:flutter/material.dart';
import 'checkin.dart';
import 'workouts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Checkin(), //MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        '/checkin': (BuildContext context) => Checkin(),
        '/workouts': (BuildContext context) => Workouts(),
      }
    );
  }
}
