// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/Setting_page.dart';

import '../women_week/monday_page.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({super.key});

  @override
  State<ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
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
                    Container(
                      child: Text(
                        "Today Meals",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
        
                      ),
                    ),
        
    
        
        
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
                                  "Tuesday",
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
        
        
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}