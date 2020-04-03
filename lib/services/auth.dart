import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {
  //Private FirebaseAuth object
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin _facebookSignIn = FacebookLogin();

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      return User(
          uid: user.uid,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
          email: user.email);
    } else {
      return null;
    }
  }

  // _auth change user
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Sign in anon
  Future sigInAnon() async {
    try {
      final AuthResult result = await _auth.signInAnonymously();
      final FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error SignIn with anonymous ${e.code.toString()}");
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error Register with email and password : ${e.message.toString()}');
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error SignIn with email and password: ${e.message.toString()}');
      return null;
    }
  }

  //Password reset
  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Sign in with Google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =  await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error SignIn with Google: ${e.message.toString()}');
      return null;
    }
  }

  //Sign in with Facebook
  Future signInWithFacebook() async {
    try {
      _facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final FacebookLoginResult result = await _facebookSignIn.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);
          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
          return _userFromFirebaseUser(user);
          break;
        case FacebookLoginStatus.cancelledByUser:
          return null;
          break;
        case FacebookLoginStatus.error:
          return null;
          break;
      }
    } catch (e) {
      print('Error SignIn with Facebook: ${e.message.toString()}');
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _facebookSignIn.logOut();
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print("Error signOut ${e.message.toString()}");
      return null;
    }
  }
}
