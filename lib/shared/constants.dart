import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TextFormField decoration
const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  fillColor:  Color.fromRGBO(128, 172, 164, 0),
  filled: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 2.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

//Function to show Toast
void toastMessage(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.brown[300],
      textColor: Colors.white,
      fontSize: 16.0);
}

// Function to Validate email
bool validateEmail(String email){
  bool valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return valid;
}