
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/pages/auth_page2.dart';
import 'package:natal_nurture_1/pages/login_page.dart';


class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---this will check to see whether the user is logged in or not---
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          //---if user is logged in (checking if user finished question page)---
          if (snapshot.hasData) 
          { 
            return AuthPage2();
          }
          else 
          {
            return LoginPage();
          }
          
        },
      ),
    );
  }
}