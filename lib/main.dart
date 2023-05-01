import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/pages/auth_page.dart';
import 'package:natal_nurture_1/pages/boarding_page.dart';
import 'package:natal_nurture_1/pages/login_page.dart';
import 'package:natal_nurture_1/pages/questions_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natal Nurture',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home:  AuthPage(),
    );
  }
}
