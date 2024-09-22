import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:home_pg/main.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential result = await _auth.signInWithCredential(credential);

        User? userDetails = result.user;

        if (userDetails != null) {
          Map<String, dynamic> userInfoMap = {
            "email": userDetails.email,
            "name": userDetails.displayName,
            "imgUrl": userDetails.photoURL,
            "id": userDetails.uid,
          };

          await DatabaseMethods().addUser(userDetails.uid, userInfoMap);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );

          // Show success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Google Sign-In Successful"),
                content: Text("You have successfully signed in with Google."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
  );
            },
          );
        }
      }
    } catch (e) {
  // Handle error here
  print("Error signing in with Google: ${e.toString()}");
  String errorMessage = "Failed to sign in with Google. Please try again later.";
  
  if (e is FirebaseAuthException) {
    errorMessage = e.message ?? "An error occurred";
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

  }
}
