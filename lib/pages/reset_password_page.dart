// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';
import 'package:natal_nurture_1/pages/login_page.dart';

class ResetPassPage extends StatefulWidget {
  ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final userEmail = TextEditingController();

  Future resetPassword() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail.text.trim());
    } on FirebaseAuthException catch (exception) {
      print(exception);

      // ---show dialog that resett password send successfully---
      Flushbar(
        margin: EdgeInsets.only(top: 3),
        borderRadius: BorderRadius.circular(10),
        maxWidth: 250,
        icon: Icon(Icons.check, color: Colors.pinkAccent, size: 25,),
        message: exception.message,
        messageText: Text("Unable to send reset password", style: TextStyle(fontSize: 16.0, color: Colors.pinkAccent,),),
        duration: Duration(milliseconds: 2200),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.white,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //---Background Image---
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/natal.png"
            ),
            fit: BoxFit.cover,
          )
        ),

        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 40,fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  width: 300,
                  child: Text(
                    "Please enter your email in order to receive a reset password message send to your email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ),

                SizedBox(height: 30,),

                MyTextField(
                  controller: userEmail, 
                  hintText: "email", obsecureText: false
                  , icon: Icon(Icons.email)
                ),

                SizedBox(height: 10),

                MyButton(onTap: () {
                  resetPassword();

                  // ---show dialog that reset password sent successfully---
                  Flushbar(
                    margin: EdgeInsets.only(top: 2),
                    borderRadius: BorderRadius.circular(10),
                    maxWidth: 250,
                    icon: Icon(Icons.check, color: Colors.pinkAccent, size: 25,),
                    message: "Password reset email sent",
                    messageText: Text("Password reset email sent", style: TextStyle(fontSize: 16.0, color: Colors.pinkAccent,),),
                    duration: Duration(milliseconds: 2200),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.white,
                  ).show(context);
                  
                  Timer(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                        context, 
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => LoginPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                    );
                  });
                }, 
                  text: "Reset Password"
                ),

                SizedBox(height: 5,),

                MyButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context, 
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => LoginPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  text: "Back",
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}