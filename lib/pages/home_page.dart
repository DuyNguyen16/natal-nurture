import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/pages/questions_page.dart';

import 'auth_page.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    
    //Sign User out method
    void SignUserOut() async{

      FirebaseAuth.instance.signOut();
    }

    return Container(
      //---Background Image---
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/background.png"
          ),
          fit: BoxFit.cover,
        )
      ),

      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                onTap: () { SignUserOut(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AuthPage()));}, text: "Sign Out")
              ]
            ),
          ),
        
      )
   );
  }
}