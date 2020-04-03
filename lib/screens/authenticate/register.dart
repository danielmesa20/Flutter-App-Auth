import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  //Constructor
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Variables
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.0,
                                fontFamily: 'Prima',
                                letterSpacing: 1.5),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an email';
                              } else if (!val.contains('@')) {
                                return 'Enter an valid email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) => setState(() => email = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter a password';
                              } else if (val.length < 6) {
                                return 'Enter a password 6+ chars long';
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            onChanged: (val) => setState(() => password = val),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Enter",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  toastMessage(
                                      'Please supply a valid email and password');
                                  setState(() => loading = false);
                                }
                              }
                            },
                          ),
                          SizedBox(height: 5.0),
                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Go to sign In with email and password",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => widget.toggleView(1),
                          ),
                          SizedBox(height: 5.0),
                          RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Go to sign In with other methods",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => widget.toggleView(0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
