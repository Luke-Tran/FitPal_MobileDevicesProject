import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  String _dialogTitle = '';
  ConfirmDialog(this._dialogTitle);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(_dialogTitle),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () { Navigator.pop(context, true); },
          child: Text('Confirm'),
        ),
        SimpleDialogOption(
          onPressed: () { Navigator.pop(context, false); },
          child: Text('Deny'),
        ),
      ],
    );
  }
}