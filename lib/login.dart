
import 'package:firebase_todo/password.dart';
import 'package:firebase_todo/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final _loginkey = GlobalKey<FormState>();
 
  bool _islogin = false;

String emailAddress = '';
String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User signed in, navigate to the profile page or perform any desired action
      print('Signed in: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // No user found or wrong password
        print('No user found or wrong password');
      } else {
        print('Error: $e');
      }
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Text(
                    'Welcome to TODO list',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                     controller: _emailController,
                    // key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Incorrect email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailAddress = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Enter your email address or user id'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  // key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                    
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      labelText: 'Enter your password'),
                      obscureText: true,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 130,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   _signInWithEmailAndPassword();
                  login(emailAddress, password, context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ),
            
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Sign_in(),
                    )),
                child: Text('New to TODO?',style: TextStyle(decoration: TextDecoration.underline),))
          ],
        ),
      ),
    );
  }
}
