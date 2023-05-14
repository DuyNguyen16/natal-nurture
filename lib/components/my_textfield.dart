// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyTextField extends StatelessWidget {
  
  final controller;
  final String hintText;
  final bool obsecureText;
  final icon;
  

  const MyTextField({
    super.key,  
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        child: TextField(
          controller: controller,
          obscureText: obsecureText,
          decoration: InputDecoration(  
            enabledBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 225, 107, 107))
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            prefixIcon: icon,
          ),
        ),
      )
    );
  }
}