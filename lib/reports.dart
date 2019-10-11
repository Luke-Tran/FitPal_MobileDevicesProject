import 'package:flutter/material.dart';
import 'navigation_app_bar.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: Text('Reports'),
    );
  }
}