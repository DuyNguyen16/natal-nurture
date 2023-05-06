// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:natal_nurture_1/pages/women_week/monday_page.dart';
import 'package:natal_nurture_1/pages/women_week/tuesday_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Setting_page.dart';

class PregPage extends StatefulWidget {
  PregPage({super.key});
  @override
  State<PregPage> createState() => _PregPageState();

}

class _PregPageState extends State<PregPage> {
  int currentIndex = 0;
  List pages = [
    PregPage(),
    ChildPage(),
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  late String userUID;

  double percentCal(int total_days, int day) {
    double percent = 1 - (day/total_days);
    return percent;
  }
  //funtion to fet user data from firebase  
  String getUserData() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }

  // declearing user from users collection
  CollectionReference user = FirebaseFirestore.instance.collection('users');


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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: 30,),
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
        
                    SizedBox(height: 20,),

                    // days remained 
                    Container(
                      child: FutureBuilder<DocumentSnapshot>(
                        
                        //Fetching data from the documentId specified of the
                        future: user.doc(getUserData()).get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) 
                        {
                          //Data is output to the user
                          if (snapshot.connectionState == ConnectionState.done) 
                          {
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            String ConceptionDate = data['Date'];
                            // remove symbol from string to get the numbers only
                            var dateList = ConceptionDate.split('-'); 
                            // converting string  (day,month,year into int in order to do calculation)
                            var nine_months = 270;
                            // get user day of conception
                            var day = int.parse(dateList[0]);
                            // get user month of conception
                            var month = int.parse(dateList[1]);
                            // get user year of conception
                            var year = int.parse(dateList[2]);
                            // get the current date
                            var now = new DateTime.now();
                            // year formatting
                            var year_formatter = new DateFormat("yyyy");
                            // current year 
                            int currrent_year = int.parse(year_formatter.format(now));
        
                            var days_remained;
        
                            if (year < currrent_year)
                            {
                              // get the current month
                              var formatter = new DateFormat('MM');
                              int current_month = int.parse(formatter.format(now));
        
                              // calculation to get days remained
                              days_remained = nine_months - ((day) + ((12 - month) * 30) + (current_month * 30));
                            }
                            else{
                              // get the current month
                              var formatter = new DateFormat('MM');
                              int current_month = int.parse(formatter.format(now));

                              // get the current day
                              var formatters = new DateFormat('dd');
                              int current_day = int.parse(formatters.format(now));
        
                              // calculation to get days remained
                              days_remained = nine_months - ((current_day - day) + ((current_month - month) * 30));
                              
                            }
                            return Center(
                              child: CircularPercentIndicator(
                                radius: 75,
                                lineWidth: 10,
                                percent: percentCal(nine_months, days_remained),
                                center: Text("${days_remained}", style: TextStyle(color: Colors.pinkAccent, fontSize: 40, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
        
                    SizedBox(height: 50,),

                    Container(
                      height: 360,
                      width: 500,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MondayPage()));
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
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
                    
                            GestureDetector(
                              onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => TuesPage()));
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
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
                    
                            Container(
                              margin: EdgeInsets.all(15),
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
                    
                            Container(
                              margin: EdgeInsets.all(15),
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
                    
                            Container(
                              margin: EdgeInsets.all(15),
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
                    
                            Container(
                              margin: EdgeInsets.all(15),
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
                    
                            Container(
                              margin: EdgeInsets.all(15),
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
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 200,),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

