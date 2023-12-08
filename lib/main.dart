import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo/firebase_options.dart';
import 'package:firebase_todo/home.dart';
import 'package:firebase_todo/loading.dart';
import 'package:firebase_todo/sign_in.dart';
import 'package:flutter/material.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  //  FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(debugShowCheckedModeBanner: false,
      home:  StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges()
      , builder: (context,snapshot){
        if(snapshot.hasData){
          return Todo();
        }else{
          return Sign_in();
        }
      })
    );
  }
}
