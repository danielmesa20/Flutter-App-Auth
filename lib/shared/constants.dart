import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
bool validateEmail(String email) {
  bool valid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return valid;
}
