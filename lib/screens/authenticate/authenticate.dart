import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/authenticate/sign_in_email.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  int showSignIn = 0;

  void toggleView(int value){
    setState(() {
      showSignIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn == 0){
      return SignIn(toggleView: toggleView);
    }else if(showSignIn == 1){
      return SignInWithEmail(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}