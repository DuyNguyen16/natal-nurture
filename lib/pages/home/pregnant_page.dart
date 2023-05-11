// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously


import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:natal_nurture_1/pages/random/classes.dart';
import 'package:natal_nurture_1/pages/food_page/women_food_page.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class PregPage extends StatefulWidget {
  const PregPage({super.key});
  @override
  State<PregPage> createState() => _PregPageState();

}

class _PregPageState extends State<PregPage> {
  // index of the current page
  int currentIndex = 0;
  // pages bottom navigator
  List pages = [
    PregPage(),
    ChildPage(),
  ];

  // Firebase initualise
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  late String userUID;
  
  // function that calculate the percentage of the days remained
  double percentCal(int totalDays, int day) {
    double percent = 1 - (day/totalDays);
    return percent;
  }

  //funtion to fet user uid from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }

  // a funtion that return a random item in a list
  String getRandomFood(List foodList) {
    var random = Random().nextInt(foodList.length);
    var random2 = Random().nextInt(foodList[random].length);
    return foodList[random][random2];
  }

  // declearing user from users collection
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  // create food rec field
  Future createFoodRec({required List thisWeekFood}) async {
      // reference to document on firebase
      final foodDoc = FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID());
      // name and items to create
      final json = {
        'thisWeekFood': thisWeekFood,
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
                      
                      SizedBox(height: 20),
                      // days remained text
                      Container(
                        child: Text(
                          "Days remained:",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                  
                        ),
                      ),
                  
                      SizedBox(height: 20),
          
                      // ===================== days remained number ====================
                      Container(
                        child: FutureBuilder<DocumentSnapshot>(
                          
                          //Fetching data from the documentId specified of the
                          future: user.doc(getUserUID()).get(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) 
                          {
                            //Data is output to the user
                            if (snapshot.connectionState == ConnectionState.done) 
                            {
                              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                              String conceptionDate = data['Date'];
                              // remove symbol from string to get the numbers only
                              var dateList = conceptionDate.split('-'); 
                              // converting string  (day,month,year into int in order to do calculation)
                              var estimatedDays = 270;
                              // get user day of conception
                              var userDay = int.parse(dateList[0]);
                              // get user month of conception
                              var userMonth = int.parse(dateList[1]);
                              // get user year of conception
                              var userYear = int.parse(dateList[2]);
                              // get the current date
                              var dateNow = DateTime.now();
                              // year formatting
                              var yearFormatter = DateFormat("yyyy");
                              // current year 
                              int currrentYear = int.parse(yearFormatter.format(dateNow));
                  
                              int daysRemained;
                  
                              if (userYear < currrentYear)
                              {
                                // get the current month
                                var formatter = DateFormat('MM');
                                int currentMonth = int.parse(formatter.format(dateNow));
                  
                                // calculation to get days remained
                                daysRemained = estimatedDays - ((userDay) + ((12 - userMonth) * 30) + (currentMonth * 30));
                              }
                              else{
                                // get the current month
                                var formatter =  DateFormat('MM');
                                int currentMonth = int.parse(formatter.format(dateNow));
          
                                // get the current day
                                var formatters =  DateFormat('dd');
                                int currentDay = int.parse(formatters.format(dateNow));
                  
                                // calculation to get days remained
                                daysRemained = estimatedDays - ((currentDay - userDay) + ((currentMonth - userMonth) * 30));      
                              }
                              return Center(
                                child: CircularPercentIndicator(
                                  radius: 75,
                                  lineWidth: 10,
                                  percent: percentCal(estimatedDays, daysRemained),
                                  center: Text("$daysRemained", style: TextStyle(color: Colors.pinkAccent, fontSize: 40, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  backgroundColor: Colors.white,
                                  progressColor: Colors.pinkAccent,
                                  circularStrokeCap: CircularStrokeCap.round,
                                )
                              );
                            }
                            return Text("Loading");
                          },
                        ),
                      ),
                      
                      SizedBox(height: 50),

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

                        // get food
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
                      
                            //get current user document
                            DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(getUserUID()).get();
                            // get current user specific field
                            Map recommendedFood = document["recommendedFood"];
                            
                            List foodList = [];
                            List thisWeekFood = [];
                            
                            // add the food from recommendedFood map into food list
                            recommendedFood.forEach((type, food) { 
                              foodList.add(food);
                            });
                            
                            // make a new thisWeekFood array items
                            for (int i = 0; i < 7; i++)
                            {
                              // get a random food from the two dimensional array (foodList)
                              thisWeekFood.add(getRandomFood(foodList));
                            }
                            createFoodRec(thisWeekFood: thisWeekFood);
                      
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
                                "Get foods",
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
          
                      // ============================ BEGIN DAYS CONTAINER ================================
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        // ==================== BUTTONS =========================
                        child: Scrollbar(
                          
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                // ================ MONDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 0, thisWeekFood: thisWeekFood)));
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
                                        "Monday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                        
                                // ================ TUESDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 1, thisWeekFood: thisWeekFood,)));
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
                                        "Tuesday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                        
                                // ================ WEDNESDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 2, thisWeekFood: thisWeekFood,)));
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
                                        "Wednesday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                        
                                // ================ THURSDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 3, thisWeekFood: thisWeekFood,)));
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
                                        "Thursday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                        
                                // ================ FRIDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 4, thisWeekFood: thisWeekFood,)));
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
                                        "Friday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                        
                                // ================ SATURDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 5, thisWeekFood: thisWeekFood,)));
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
                                        "Saturday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                                
                                // ================ SUNDAY BUTTON ===============
                                GestureDetector(
                                  onTap: () async {
                                    //get current user document
                                    DocumentSnapshot document = await FirebaseFirestore.instance.collection('currentWeekFoods').doc(getUserUID()).get();
                                    // get current user specific field
                                    List thisWeekFood = document["thisWeekFood"];
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodPage(index: 6, thisWeekFood: thisWeekFood,)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                                    height: 80,
                                    width: 280,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Sunday",
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
                      ),
                      // ============================ DAYS CONTAINER ================================
                    ],
                ),
              ),
        ),
      ),
    );
  }
}

