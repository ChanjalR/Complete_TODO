



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/home.dart';
import 'package:flutter/material.dart';

signup(String emailAddress, String password) async {
  try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  print('singed up on firebase');
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}


Future<void> login(String emailAddress, String password, BuildContext context) async {
  try {
    print('loginnnnnnnnnnnnnnnn');
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    print('Sign-in successful: ${userCredential.user?.uid}');
    
    // Navigate to the Home screen after successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    
  } catch (e) {
    print('Error during sign-in: $e');
  }
}
