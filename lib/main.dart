import 'dart:io';
import 'package:flutter/material.dart';
import 'package:regiter_forms/register_forms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:regiter_forms/success_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCUDEFI-EE_DrRrVNg7drp2g11Ha_L6APk", 
    appId: "1:570429932571:android:93ca5978c70a04e86764be",
     messagingSenderId:"570429932571",
      projectId: "registerapp-46066",
      storageBucket: 'registerapp-46066.appspot.com')
  )
  :await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "register_forms":(context) => RegisterPage(),
        "success_screen":(context) => success_screen()
      },
      home: const RegisterPage()
    );
  }
}