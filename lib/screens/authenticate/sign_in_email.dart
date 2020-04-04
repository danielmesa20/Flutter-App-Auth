import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/CustomButton.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  //Variables
  final Function toggleView;
  //Constructor
  SignInWithEmail({this.toggleView});

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  //Variables
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  bool loading = false, obscureTextState = true;
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              hintText: 'Enter Your Email Here',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              fillColor: Color.fromRGBO(128, 172, 164, 0),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.brown,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                  width: 2.0,
                                ),
                              ),
                            ),
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
                            onFieldSubmitted: (v) =>
                                FocusScope.of(context).requestFocus(focus),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            enableSuggestions: true,
                            focusNode: focus,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.security,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              hintText: 'Enter Your Password Here',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              fillColor: Color.fromRGBO(128, 172, 164, 0),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.brown,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink,
                                  width: 2.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureTextState == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () => setState(
                                    () => obscureTextState = !obscureTextState),
                              ),
                            ),
                            obscureText: obscureTextState,
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
                          CustomButton(
                            backgroundColor: Colors.pink,
                            text: "Enter",
                            textColor: Colors.white,
                            actionOnpressed: () async {
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
                          CustomButton(
                            backgroundColor: Colors.blue,
                            text: "Go to Register",
                            textColor: Colors.white,
                            actionOnpressed: () => widget.toggleView(2),
                          ),
                          CustomButton(
                            backgroundColor: Colors.grey,
                            text: "Reset password",
                            textColor: Colors.white,
                            actionOnpressed: () async {
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
                          CustomButton(
                            backgroundColor: Colors.white,
                            text: "Sign with others methods",
                            textColor: Colors.black,
                            actionOnpressed: () => widget.toggleView(0),
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
