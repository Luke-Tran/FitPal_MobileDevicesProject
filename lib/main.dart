import 'package:flutter/material.dart';
import 'bottom_nav_bar_controller.dart';
import 'food_form.dart';
import 'workout_form.dart';
import 'pages/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: BottomNavBarController(),
      routes: <String, WidgetBuilder> {
        '/foodform': (BuildContext context) => FoodForm(),
        '/workoutform': (BuildContext context) => WorkoutForm(),
        '/signin': (BuildContext context) => SignInPage(),
      },
    );
  }
}
