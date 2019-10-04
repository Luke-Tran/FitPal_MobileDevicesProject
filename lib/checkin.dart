import 'package:flutter/material.dart';
import 'navigation_app_bar.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: Text('Check-in'),
    );
  }
}