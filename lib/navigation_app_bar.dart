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
            Navigator.pushNamed(context, '/checkin');
          },
        ),
        FlatButton(
          child: Text('Goals'),
          onPressed: () {
            Navigator.pushNamed(context, '/goals');
          }
        ),
        FlatButton(
          child: Text('Reports'),
          onPressed: () {
            Navigator.pushNamed(context, '/reports');
          }
        ),
        FlatButton(
          child: Text('Workouts'),
          onPressed: () {
            Navigator.pushNamed(context, '/workouts');
          },
        ),
      ],
    );
  }
}