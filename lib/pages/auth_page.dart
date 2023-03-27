import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/home_page.dart';
import 'package:natal_nurture_1/pages/login_or_register_page.dart';
import 'package:natal_nurture_1/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---this will check to see whether the user is logged in or not---
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //---if user is logged in (checking if user finished question page)---
          if (snapshot.hasData) {
            //need to code if the user answer question apge  before returning homePage()
            return HomePage();
          }
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}