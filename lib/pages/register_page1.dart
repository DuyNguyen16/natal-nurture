import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_textfield.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
    final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userPasswordConfirm = TextEditingController();

  void signUserUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmail.text, 
            password: userPassword.text,
          );
    }
    on FirebaseAuthException catch(e) {
      return showDialog(
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
            "message",
            style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(height: 120,),
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
                  MyButton(
                    onTap: signUserUp,
                    text: 'Sign Up',
                  ),
        ]),
      ),
    );
  }
}