import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';
import 'package:natal_nurture_1/pages/auth_page.dart';
import 'package:natal_nurture_1/pages/home_page.dart';

import '../components/my_button.dart';

class QuestionPage extends StatefulWidget {
   QuestionPage({super.key});
  
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
              MyButton(onTap: () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));}, text: "Continue"),
              ]
            ),
          ),
        
      )
   );
  }
}