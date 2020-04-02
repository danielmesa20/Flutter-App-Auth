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
  @override
  Widget build(BuildContext context) {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Brew Crew"),
              centerTitle: true
            ),
            body: Center(
              heightFactor: 1.5,
              child: Container(
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
                                "SIGN IN WITH EMAIL",
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Email'),
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
                                  "Sign in",
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
                                }
                            ),
                            RaisedButton(
                                color: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Go to Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  widget.toggleView(2);
                                }),
                              RaisedButton(
                                color: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Sign with others methods",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  widget.toggleView(0);
                                }),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
  }
}