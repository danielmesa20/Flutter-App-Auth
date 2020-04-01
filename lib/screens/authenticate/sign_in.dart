import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error;

  void toastMessage(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Brew Crew"),
              centerTitle: true,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an email';
                              } else if (!val.contains('@')) {
                                return 'Enter an valid email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an password';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                "Sign in with email and password",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true); 
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  if (result == null) {
                                    toastMessage('Please supply a valid email and password');
                                    setState(() => loading = false); 
                                  }
                                }
                              }),
                          SizedBox(height: 10.0),
                          GoogleSignInButton(
                            darkMode: false, // default: false
                            borderRadius: 8.0,
                            textStyle: TextStyle(fontSize: 15),
                            text: "Sign in with Google",
                            onPressed: () async {
                              setState(() => loading = true); 
                              dynamic result = await _auth.signInWithGoogle();
                              if (result == null) {
                                toastMessage('There was a problem trying to login with Google');
                                setState(() => loading = false);   
                              }
                            },
                          ),
                          SizedBox(height: 10.0),
                          FacebookSignInButton(
                              borderRadius: 8.0,
                              text: 'Sign in with Facebook',
                              textStyle:
                                  TextStyle(fontSize: 15, color: Colors.white),
                              onPressed: () async {
                                setState(() => loading = true); 
                                dynamic result = await _auth.signInWithFacebook();
                                if (result == null) {
                                  toastMessage('There was a problem trying to login with Facebook');
                                  setState(() => loading = false); 
                                }
                              }),
                          SizedBox(height: 10.0),
                          FlatButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.white)),
                            icon: Icon(Icons.account_circle),
                            color: Colors.white,
                            label: Text("Sign in Anonymous"),
                            onPressed: () async {
                              setState(() => loading = true); 
                              dynamic result = await _auth.sigInAnon();
                              if (result == null) {
                                toastMessage('There was a problem trying to login');
                                setState(() => loading = false); 
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    )),
              ),
            ),
          );
  }
}
