import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        FlatButton(
          child: Text('Checkin'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/checkin');
          },
        ),
        FlatButton(
          child: Text('Goals'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/goals');
          }
        ),
        FlatButton(
          child: Text('Reports'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/reports');
          }
        ),
        FlatButton(
          child: Text('Workouts'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/workouts');
          },
        ),
      ],
    );
  }
}