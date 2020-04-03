import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  final Function toggleView;
  SignInWithEmail({this.toggleView});

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  //Variables
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
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
              heightFactor: 2.0,
              child: Container(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            "SIGN IN WITH EMAIL",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35.0,
                              fontFamily: 'Prima',
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.next,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Enter Your Email Here',
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: Colors.black)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an email';
                              } else if (!validateEmail(val)) {
                                return 'Enter an valid email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) => setState(() => email = val),
                            onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(focus),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            enableSuggestions: true,
                            focusNode: focus,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Enter Your Password Here',
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.black,
                                )),
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter an password';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) => setState(() => password = val),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Enter",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  toastMessage(
                                      'Please supply a valid email and password');
                                  setState(() => loading = false);
                                }
                              }
                            },
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Go to Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => widget.toggleView(2),
                          ),
                          RaisedButton(
                            color: Colors.grey,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Reset password",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (email.isEmpty) {
                                toastMessage('Please supply your email');
                              } else {
                                setState(() => loading = true);
                                await _auth.resetPassword(email);
                                setState(() => loading = false);
                                toastMessage('Please check your email');
                              }
                            },
                          ),
                          RaisedButton(
                            color: Colors.white,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Sign with others methods",
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
