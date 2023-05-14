// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';
import 'package:natal_nurture_1/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userPasswordConfirm = TextEditingController();

  //---Sign user up function (Email and Password Method)---
  void signUserUp() async {
   // ---check if the user enter informations---
    if (userEmail.text.isEmpty || userPassword.text.isEmpty|| userPasswordConfirm.text.isEmpty)
    {
      return myMessageDialog('Please enter informations');
    }

    //---try creating user account---
    
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail.text) == true) 
    {
      //---check length of password---
      if ((userPassword.text).length < 6)
      {
        return myMessageDialog('Password should be at least 6 characters');
      }
      //---check if passwords match---
      if (userPasswordConfirm.text == userPassword.text) 
      {
        try
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmail.text, 
            password: userPassword.text,
          );
        }
        //---check to see if there is an existing account---
        on FirebaseAuthException catch (exception) {
        //---pop the loading circle---
          Navigator.pop(context);
          //show error to user
          
            return myMessageDialog("Email already in use");
          
        }
      } 
      else {
        return myMessageDialog('Password do not match');
      }
    } 
    else {
      return myMessageDialog('Invalid Email');
    }
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
            style: TextStyle(color: Colors.white),
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
                  "Welcome!",
                  style: TextStyle(fontWeight: FontWeight.bold, 
                  fontSize: 40,
                  color: Colors.pinkAccent,            
                  ),
                ),
            
                const SizedBox(height: 7,),
                //---Welcome back text---
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
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

                SizedBox(height: 7,),

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

                //---confirm password textfield---
                MyTextField(
                  hintText: 'Confirm Password',
                  obsecureText: true,
                  controller: userPasswordConfirm,
                  icon: Icon(
                    Icons.password,
                    color: Colors.pinkAccent,
                  ),
                ),
            
                SizedBox(height: 7,),
                
                

                SizedBox(height: 15,),
            
                //---sign up button---
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),
            
                const SizedBox(height: 17),
            
                //---already have an account?---
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => LoginPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Text(
                       'Login now',
                        style: TextStyle(
                         fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ]
                )
              ],
                      ),
            ),
        )),
      ),
      
    );
    
  }
}
