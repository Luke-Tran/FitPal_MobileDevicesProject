import 'package:flutter/material.dart';
import 'checkin.dart';
import 'goals.dart';
import 'reports.dart';
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
        '/goals': (BuildContext context) => Goals(),
        '/reports': (BuildContext context) => Reports(),
        '/workouts': (BuildContext context) => Workouts(),
      }
    );
  }
}
