// ignore_for_file: prefer_const_constructors, use_build_context_synchronously


import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/Setting_page.dart';
import 'package:natal_nurture_1/pages/food_page/child_food_page.dart';
import 'package:natal_nurture_1/pages/food_page/women_food_page.dart';
import 'package:natal_nurture_1/pages/home/navigator.dart';


class ChildPage extends StatelessWidget {
   ChildPage({super.key});

  // Firebase initualise
  final FirebaseAuth auth = FirebaseAuth.instance;

  late String userUID;

  //funtion to fet user uid from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   userUID = user!.uid;
   return userUID;
  }

  // a funtion that return a random item in a list
  String getRandomFood(List foodList) {
    var random = Random().nextInt(foodList.length);
    return foodList[random];
  }

  Future createFoodRec({required List todayFoods}) async {
      // reference to document on firebase
      final foodDoc = FirebaseFirestore.instance.collection('todayFoods').doc(getUserUID());
      // name and items to create
      final json = {
        'todayFoods': todayFoods,
      };
      await foodDoc.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        
        body: Container(
          //---Background Image---
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/home.png"
                ),
              fit: BoxFit.cover,
              
            )
          ),

          
            child: SafeArea(
              child: Center(
                child: Column(
                    children: [
                      
                      SizedBox(height: 60),

                      // days remained text
                      Container(
                        child: Text(
                          "Today meals",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                  
                        ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        child: Text("😀", style: TextStyle(fontSize: 80),),
                      ),

                      SizedBox(height: 67),

                      // get food button
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),

                        // get food button
                        child: GestureDetector(
                          onTap: () async {
                      
                            //show loading circle
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            );  
                      
                            //get kid food breakfast recommend
                            DocumentSnapshot document = await FirebaseFirestore.instance.collection('foods').doc('kid-food-id').get();
                            // get breakfast field
                            List breakfast = document["breakfast"];
                            List lunch = document["lunch"];
                            List dinner = document["dinner"];
                            
                            List todayFoods = [];
                            
                            // add food to list
                            todayFoods.add(getRandomFood(breakfast));
                            todayFoods.add(getRandomFood(lunch));
                            todayFoods.add(getRandomFood(dinner));
                            
                            createFoodRec(todayFoods: (todayFoods));
                      
                            // pop the loading circle
                            Navigator.pop(context);
                      
                            // show dialog that food get successfully
                            Flushbar(
                              margin: EdgeInsets.only(top: 5),
                              borderRadius: BorderRadius.circular(10),
                              maxWidth: 250,
                              icon: Icon(Icons.check, color: Colors.pinkAccent, size: 25,),
                              message: "Successfully get foods",
                              messageText: Text("Successfully get foods", style: TextStyle(fontSize: 16.0, color: Colors.pinkAccent,),),
                              duration: Duration(milliseconds: 2200),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.white,
                            ).show(context);
                          },
                      
                          child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "Get Foods",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),

                      // ============================ BEGIN TODAY CONTAINER ==============================
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, -5), 
                            ),
                          ],
                        ),
                      
                        // ==================== BUTTONS =========================
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              // ================ BREAKFAST BUTTON ===============
                              GestureDetector(
                                onTap: () async {
                                  //get current food documebt
                                  DocumentSnapshot document = await FirebaseFirestore.instance.collection("todayFoods").doc(getUserUID()).get();
                                  // get today food fied
                                  List todayFoods = document["todayFoods"];
                                  
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChildFoodPage(index: 0, todayFoods: todayFoods,)));
                              
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left:15, right: 15, top: 15),
                                  height: 80,
                                  width: 280,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    
                                    child: Text(
                                      "Breakfast",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                                ),
                              ),

                              // ================ LUNCH BUTTON ===============
                              GestureDetector(
                                onTap: () async {
                                //get current food documebt
                                  DocumentSnapshot document = await FirebaseFirestore.instance.collection("todayFoods").doc(getUserUID()).get();
                                  // get today food fied
                                  List todayFoods = document["todayFoods"];
                                  
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChildFoodPage(index: 1, todayFoods: todayFoods)));
                                
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                                  height: 80,
                                  width: 280,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lunch",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                                ),
                              ),

                              // ================ DINNER BUTTON ===============
                              GestureDetector(
                                onTap: () async {
                                //get current food documebt
                                  DocumentSnapshot document = await FirebaseFirestore.instance.collection("todayFoods").doc(getUserUID()).get();
                                  // get today food fied
                                  List todayFoods = document["todayFoods"];
                                  
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChildFoodPage(index: 2, todayFoods: todayFoods,)));
                                
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                                  height: 80,
                                  width: 280,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Dinner",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      // ============================ END TODAY CONTAINER ================================
                    ],
                ),
              ),
        ),
      ),
  );
  }
}