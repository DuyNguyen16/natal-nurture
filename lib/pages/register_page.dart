// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  //---register now button ontap funtion---
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });
  
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final controller = TextEditingController();
  late String userUID;
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  //---funtion to fetch user UID from firebase---
  String getUserUID() {
    //---get current user---
   final user = auth.currentUser;
   userUID = user!.uid;
   return userUID;
  }

  //---Sign user up function (Email and Password Method)---
  void signUserUp() async {

   // ---check if the user enter informations---
    if (emailController.text.isEmpty || passwordController.text.isEmpty|| passwordConfirmController.text.isEmpty)
    {
      myMessageDialog('Please enter informations');
    }

    //---try creating user account---
    
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text) == true) 
    {
      //---check length of password---
      if ((passwordController.text).length < 6)
      {
        myMessageDialog('Password should be at least 6 characters');
      }
      //---check if passwords match---
      if (passwordConfirmController.text == passwordController.text) 
      {
        try
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text,
          );
        }
        //---check to see if there is an existing account---
        on FirebaseAuthException catch (exception) {
        //---pop the loading circle---
          Navigator.pop(context);
          //---Check to see if user email is correct---
          if (exception.code == 'email-already-exists') {
            //show error to user
            return myMessageDialog("email already in use");
          } 
        }
      } 
      else {
        myMessageDialog('Password do not match');
      }
    } 
    else {
      myMessageDialog('Invalid Email');
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
                  controller: emailController,
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
                  controller: passwordController,
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
                  controller: passwordConfirmController,
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
                      onTap: widget.onTap,
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
