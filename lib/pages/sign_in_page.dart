import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../database/db_model.dart';
import '../globals.dart' as globals;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _model = DBModel();
  String _buttonText = 'Sign-in with Google';
  String _pageTitle = 'Sign in';
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
        _pageTitle = 'Signed in as'
      });
    } catch(error) {
      print(error);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _buttonText = 'Sign in with Google';
    });
    globals.isLoggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget _getProfilePic(String url) {
      if (url != "") {
        return CircleAvatar(
          radius: 45.0,
          backgroundImage: NetworkImage(url),
        );
      }
      else {
        return SizedBox(height: 0.0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-in'),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _pageTitle,
              ),
              _getProfilePic(globals.profilePic),
              SizedBox(height: 10.0),
              OutlineButton(
                splashColor: Colors.grey,
                onPressed: () {
                  if (!globals.isLoggedIn) {
                    print('logging in');
                    _login();
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_buttonText),
                    ],
                  ),
                ),
              ),
            ],  
          ),
        ),
      ),
    );
  }
}