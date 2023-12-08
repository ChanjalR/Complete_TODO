
import 'package:firebase_todo/modes.dart';
import 'package:firebase_todo/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profiles extends StatefulWidget {
  const profiles({super.key});

  @override
  State<profiles> createState() => _profilesState();
}

class _profilesState extends State<profiles> {

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                logoutpop(context);
              },
              child: Container(
                height: 80,
                width: 400,
                color: Colors.grey,
                child: Center(child: Text('Sign out',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
              //   print('pressed....');
              //  Provider.of<ThemeProvider>(context, listen: false)
              //           .toggleTheme();
              },
              child: Container(
                height: 80,
                width: 400,
                color: Colors.grey,
                child: Center(child: Text('Dark mode',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}