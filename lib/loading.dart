import 'package:firebase_todo/home.dart';
import 'package:firebase_todo/sign_in.dart';
import 'package:flutter/material.dart';
class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {


  Future<void> gologin() async {
    await Future.delayed(Duration(seconds: 3));
    print('3333333');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Home(),
    ));
  }

  @override
  void initState() {
    gologin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Sign_in()));
        },
        child: Container(
          color: Colors.white,
          child: Center(
              child: Text(
            'TODO',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
