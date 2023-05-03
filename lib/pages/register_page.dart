// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  //---register now button ontap funtion
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });
  
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userPasswordConfirm = TextEditingController();
  final controller = TextEditingController();
  late String userUID;
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  //funtion to fet user data from firebase  
  String getUserData() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }


  //---Sign user in method (Email and Password Method)---
  void signUserUp() async {

    //---try creating user account---
    try {
        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userEmail.text) == true) {
          if (userPasswordConfirm.text == userPassword.text) {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userEmail.text, 
              password: userPassword.text,
            );
          } 
          else {
            showDialog(
              context: context, 
              builder: (context) {
                return const AlertDialog(
                  backgroundColor: Colors.pinkAccent,
                  title: Center(
                    child: Text(
                    'Password do not match',
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        } 
        else {
          showDialog(
            context: context, 
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.pinkAccent,
                title: Center(
                  child: Text(
                  'Invalid Email',
                  style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        }
        
      }
 
    //---check to see if there is an existing account---
    on FirebaseAuthException catch (e) {
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
    }
  }

  //---wrong email error message function---
  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text(
            'Incorrect Email or Password'
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
                  "Welcome!",
                  style: TextStyle(fontWeight: FontWeight.bold, 
                  fontSize: 40,
                  color: Colors.white             
                  ),
                ),
            
                const SizedBox(height: 7,),
                //---Welcome back text---
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(color: Colors.white, fontSize: 17),
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
                    Text('Already have an account?'),
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
