import 'package:firebase_todo/login.dart';
import 'package:firebase_todo/password.dart';
import 'package:flutter/material.dart';


class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);


  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {

  final _signKey = GlobalKey<FormState>();
 

  // bool _islogin = false;

  String email = '';
  String password = '';
  String username = '';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Text(
                      'Google authentication',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _signKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          email = value!;
                        });
                        
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Enter your email address'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                       keyboardType: TextInputType.name,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.toString().length<4) {
                          return 'user name is too small ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                        
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Enter your name'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.toString().length<4) {
                          return 'Enter a strong password';
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
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    
                    setState(() {
                      if(_signKey.currentState!.validate()){
                        _signKey.currentState!.save();
                        signup(email, password,);
                        // signPopup(context);
                        print('signnnnn');
                      }
                      
                    });
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
                  },
                
                  child: Text(
                    'Already a user?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),

                  
                
            ],
          ),
        ),
      ),
    );
  }
}
