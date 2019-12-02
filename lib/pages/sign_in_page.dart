import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../database/db_model.dart';
import '../globals.dart' as globals;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //bool _isLoggedIn = false;
  final _model = DBModel();
  String _buttonText = 'Sign-in';

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser.displayName);
      print(_googleSignIn.currentUser.email);
      globals.isLoggedIn = true;
      globals.userEmail = _googleSignIn.currentUser.email;
      globals.profilePic = _googleSignIn.currentUser.photoUrl;
      await _model.getWorkoutsFromCloud();
      setState(() {
        _buttonText = 'Signed in';
      });
    } catch(error) {
      print(error);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      //_isLoggedIn = false;
      //globals.isLoggedIn = false;
      _buttonText = 'Sign-in';
    });
    globals.isLoggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-in'),
        backgroundColor: Colors.black54,
      ),
      body: FlatButton(
        onPressed: () {
          //if (!_isLoggedIn) {
          if (!globals.isLoggedIn) {
            print('logging in');
            _login();
          }
        },
        child: Text(_buttonText),
      ),
    );
  }
}