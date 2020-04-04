import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/CustomButton.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignIn extends StatefulWidget {
  //Change sceene
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 50.0,
                  ),
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'Prima',
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            GoogleSignInButton(
                              darkMode: false, // default: false
                              borderRadius: 8.0,
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),
                              text: "Sign in with Google",
                              onPressed: () async {
                                setState(() => loading = true);
                                dynamic result = await _auth.signInWithGoogle();
                                if (result == null) {
                                  toastMessage(
                                      'There was a problem trying to login with Google');
                                  setState(() => loading = false);
                                }
                              },
                            ),
                            SizedBox(height: 10.0),
                            FacebookSignInButton(
                              borderRadius: 8.0,
                              text: 'Sign in with Facebook',
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithFacebook();
                                if (result == null) {
                                  toastMessage(
                                      'There was a problem trying to login with Facebook');
                                  setState(() => loading = false);
                                }
                              },
                            ),
                            SizedBox(height: 10.0),
                            CustomButton(
                              backgroundColor: Colors.pink,
                              text: "Sign in with email and password",
                              textColor: Colors.white,
                              actionOnpressed: () => widget.toggleView(1),
                            ),
                            SizedBox(height: 10.0),
                            FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              icon: Icon(Icons.account_circle),
                              color: Colors.white,
                              label: Text("Sign in Anonymous"),
                              onPressed: () async {
                                setState(() => loading = true);
                                dynamic result = await _auth.sigInAnon();
                                if (result == null) {
                                  toastMessage(
                                      'There was a problem trying to login');
                                  setState(() => loading = false);
                                }
                              },
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
  }
}
