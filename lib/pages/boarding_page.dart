// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/my_textfield.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  // page controller
  final page_controller = PageController();
  final controller = TextEditingController();
  late String userUID;

  //funtion to fet user data from firebase  
  String getUserData() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }

  // date controller
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  
        child: PageView(
          // page view controller to change pages
          controller: page_controller,
          children: [
            // PAGE 1
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 140),
                          Container(
                            child: Text(
                              "Welcome!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white,
                              
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          Container(
                            
                            width: 300,
                            child: Text(
                              "Natal Nurture is a pregnancy app the provides users with informations on what to to eat during their pregnacy.",
                              style: TextStyle(
                                color: Colors.white, 
                                fontSize: 17,
                          
                              ),
                          
                            ),
                          ),

                          SizedBox(height: 100),

                          MyButton(onTap: () => page_controller.jumpToPage(1), text: "Next"),
                          
                          SizedBox(height: 240),

                          Container(
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: page_controller,
                                count: 3,
                                effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PAGE 2
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 150),

                          Container(
                            child: Text(
                              "Date of conception",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 40),
                        
                          Container(
                            width: 330,
                            child: TextField(
                              
                              controller: date,
                              decoration: InputDecoration(
                                enabledBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 225, 107, 107))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Select",
                                prefixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              onTap: () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), 
                                  firstDate: DateTime(2022, ), 
                                  lastDate: DateTime.now());

                                  if (pickeddate != null) {
                                    setState(() {
                                      date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                                    });
                                  }
                                
                              },
                            ),
                          ),

                          SizedBox(height: 15),
                          MyButton(onTap: () => page_controller.jumpToPage(2), text: "Next"),

                          SizedBox(height: 8),

                          MyButton(onTap: () => page_controller.jumpToPage(0), text: "Back"),

                          SizedBox(height: 230),

                          Center(
                            child: SmoothPageIndicator(
                              controller: page_controller,
                              count: 3,
                              effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // PAGE 3
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                      
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(date.text),
                          MyButton(
                            onTap: () {
                              
                              final selected_date = date.text;

                              createUser(selected_date: selected_date);
                            },
                            text: "Enter",
                          ),
                          SizedBox(height: 650),
                          Center(
                            child: SmoothPageIndicator(
                              controller: page_controller,
                              count: 3,
                              effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    
  }
  Future createUser({required String selected_date}) async {
      // reference to document on firebase
      final UserDoc = FirebaseFirestore.instance.collection('users').doc(getUserData());

      final json = {
        'name': "Duy",
        'Date': selected_date,
      };
      await UserDoc.set(json);
  }
}