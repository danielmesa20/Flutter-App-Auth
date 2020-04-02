import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  bool loading = false;
 
  @override
  Widget build(BuildContext context) {
    return
      loading ? Loading() 
      : Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Brew Crew"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
            ), 
            label: Text("logout"),
            onPressed: () async {
              setState(() => loading = true); 
              dynamic result = await _auth.signOut();
              if(result == null){
                toastMessage('Sign Out Fail');
                setState(() => loading = false); 
              }
            }, 
          )
        ],
      ),
    );
  }
}