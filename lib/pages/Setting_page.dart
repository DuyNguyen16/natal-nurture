import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/pages/home/navigator.dart';

import 'auth_page.dart';

class SettingsPage extends StatefulWidget {
   SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    
    //Sign User out method
    void SignUserOut() async{

      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      body: Container(
        //---Background Image---
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/background.png"
            ),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  onTap: () { SignUserOut(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AuthPage()));}, text: "Sign Out"),
                TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorPage()));}, child: Text("Back")),  
              ],
            ),
          ),
        ),
      )
    );
  }
}