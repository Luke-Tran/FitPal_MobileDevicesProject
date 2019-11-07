import 'package:flutter/material.dart';
import 'package:mobile_devices_project/reports.dart';
import 'package:mobile_devices_project/workouts.dart';

import 'checkin.dart';
import 'goals.dart';

/*
  This class implements a persistent bottom navigation bar, where only one navigation bar instance exists for the entire app.
  It stores page states using Flutter's PageStorage, and calls on it for navigation between pages.
*/

class BottomNavBarController extends StatefulWidget {

  _BottomNavBarControllerState createState() => _BottomNavBarControllerState();

}

class _BottomNavBarControllerState extends State<BottomNavBarController> {

  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket(); //The bucket that flutter automatically uses to store page data

  //A stored list of the pages that map to each tab
  final List<Widget> pages = [
    Checkin(
      key: PageStorageKey('checkin'),
    ),
    Goals(
      key: PageStorageKey('goals'),
    ),
    Reports(
      key: PageStorageKey('reports'),
    ),
    Workouts(
      key: PageStorageKey('workouts'),
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      //Temporary appbar
      appBar: AppBar(
        title: Text("FitPal"),
      ),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: _bucket,
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Checkin'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Goals'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Reports'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Workouts'),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}