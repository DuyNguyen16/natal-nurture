// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';
import 'package:natal_nurture_1/pages/login_page.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {

  final emailController = TextEditingController();
  void resetPassword() {
    
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
              children: [
                MyTextField(controller: emailController, hintText: "email", obsecureText: false, icon: Icon(Icons.email)),

                SizedBox(height: 10),

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