import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser.displayName);
      print(_googleSignIn.currentUser.email);
      setState(() {
        _isLoggedIn = true;
      });
    } catch(error) {
      print(error);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
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
          if (!_isLoggedIn) {
            _login();
          }
        },
        child: Text('Sign-in'),
      ),
    );
  }
}