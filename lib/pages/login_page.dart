// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  //---register now button ontap funtion
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });
  
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //---Sign user in method (Email and Password Method)---
  void SignUserIn() async {

    //---show loading circle---
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  
    //---try sign in---
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
      
      //---pop the loading circle---
      Navigator.pop(context);

      //---check to see if there is an existing account---
    } on FirebaseAuthException catch (e) {
      //---pop the loading circle---
      Navigator.pop(context);
      //---Check to see if user email is correct---
      if (e.code == 'user-not-found') {
        //show error to user
        wrongEmailMessage();
      } 
      //---Check to see if user password is correct---
      else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
      Navigator.pop(context);
    }
  }
      

  //---wrong email error message function---
  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.pinkAccent,
          title: Text(
            'Incorrect Email or Password',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  //---wrong password error message function---
  void wrongPasswordMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(  
          backgroundColor: Colors.pinkAccent,
          title: Text(
            'Incorrect Email or Password',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      //---Background Image---
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/natal.png"
              ),
            fit: BoxFit.cover,
            )
          ),

      //---Components in body---
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //---logo---
              
                  //---hello again!---
                  Text(
                    "Hello Again!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.pinkAccent,
                      
                    ),
                  ),
              
                  const SizedBox(height: 7,),

                  //---Welcome back text---
                  Text(
                    "Welcome back you've been missed",
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 17,

                    ),

                  ),

                  SizedBox(height: 20,),

                  //---email textfield---
                  MyTextField(
                    hintText: "Email",
                    obsecureText: false,
                    controller: emailController,
                    icon: Icon(
                      Icons.email,
                      color: Colors.pinkAccent,
                    ),
                    
                  ),
                  SizedBox(height: 8,),

                  //---password textfield---
                  MyTextField(
                    hintText: 'Password',
                    obsecureText: true,
                    controller: passwordController,
                    icon: Icon(
                      Icons.password,
                      color: Colors.pinkAccent,
                    ),
                    
                  ),
              
                  SizedBox(height: 7,),
                  
                  //---forgot password---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
              
                  //---sign in button---
                  MyButton(
                    onTap: SignUserIn,
                    text: 'Sign In',
                  ),
              
                  const SizedBox(height: 17),
              
                  //---not a member? register now---
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                        'Register now',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
