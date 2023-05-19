// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';
import 'package:natal_nurture_1/pages/register_page.dart';
import 'package:natal_nurture_1/pages/register_page1.dart';
import 'package:natal_nurture_1/pages/reset_password_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  //---Sign user in function (Email and Password Method)---
  void signUserIn() async {
    // check if the user enter informations
    if (userEmail.text.isEmpty || userPassword.text.isEmpty)
    {
      return myMessageDialog("Please enter informations");
    }

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
        email: userEmail.text, 
        password: userPassword.text,
      );
      
      //---pop the loading circle---
      Navigator.pop(context);

      //---check to see if there is an existing account---
    } on FirebaseAuthException catch (exception) {
      //---pop the loading circle---
      Navigator.pop(context);
      //---Check to see if user email is correct---
      if (exception.code == 'user-not-found') {
        //show error to user
        return myMessageDialog("Incorrect email");
        
      } 
      //---Check to see if user password is correct---
      else if (exception.code == 'wrong-password'){
        return myMessageDialog("Incorrect password");
      }
      else {
        return showDialog(
          context: context, 
          builder: (context) {
            Future.delayed(Duration(seconds: 7), () {
              Navigator.of(context).pop(true);
            });
            //---Alert user---
            return  AlertDialog(
              backgroundColor: Colors.pinkAccent,
              title: Center(
                child: Text(
                "Account has been temporarily disabled due to many failed login attempts, please try again in a few minutes",
                style: TextStyle(color: Colors.white), textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      }
    }
    //---pop the loading circle---
    Navigator.pop(context);
  }
      
  //---message function---
  void myMessageDialog(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        //---Alert user---
        return  AlertDialog(
          backgroundColor: Colors.pinkAccent,
          title: Center(
            child: Text(
            message,
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center,
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
                    controller: userEmail,
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
                    controller: userPassword,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => ResetPassPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
              
                  //---sign in button---
                  MyButton(
                    onTap: signUserIn,
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
                        onTap: () {
                          Navigator.push(
                            context, 
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => RegisterPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
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
