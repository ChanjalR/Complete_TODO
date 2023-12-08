
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/login.dart';
import 'package:firebase_todo/sign_in.dart';
import 'package:flutter/material.dart';

void signPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the Dialog widget here
        return AlertDialog(
          title: Text('Sign in successful'),
          content: Text('Click ok to Login page'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

 Future<void> logout() async {
    try {
      // Check if there's a user signed in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is signed in, proceed with sign-out
        await FirebaseAuth.instance.signOut();
        print("User signed out successfully");
      } else {
        // No user is signed in
        print("No user signed in");
      }
    } catch (e) {
      // Handle sign-out errors
      print("Error signing out: $e");
    }
  }

void logoutpop(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the Dialog widget here
        return AlertDialog(
          title: Text('Sign out?'),
          content: Text('Are you sure'),
          actions: <Widget>[
            TextButton(
            onPressed: () {
              Navigator.pop(context); // This will close the dialog
            },
            child: Text('Cancel'),
          ),
            TextButton(
              onPressed: () {
                logout();  //logout function inside logout popup---------------------
               Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sign_in(),
                      ));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }