// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 0), 
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "images/tips.png" 
                      )
                    )
                  ),
                ),
              ]
            ),

            SizedBox(height: 20,),

            Container(
              width: 340,
              height: 310,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  ),
                          ],
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Foods to avoid during pregnancy:",
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: ListBody(
                        children: [
                          Row(
                            children: [
                              Text("1.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Soft cheeses", style: TextStyle(fontSize: 20))
                            ],
                          ),
                          
                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("2.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Undercooked meat", style: TextStyle(fontSize: 20))
                            ],
                          ),
                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("3.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Undercooked fish", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("4.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Undercooked seafood", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("5.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Unwashed fruits and vegetables", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("6.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Soft-serve ice cream", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("7.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Undercooked or raw eggs", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),

                          Row(
                            children: [
                              Text("8.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Unpasteurised milk", style: TextStyle(fontSize: 20))
                            ],
                          ),

                          SizedBox(height: 3,),
                          
                          Row(
                            children: [
                              Text("9.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                              Text(" Alcohol", style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ]
                      ),
                    )
                  ]
                ),
              )
            )
          ]
        ),
      ),
    );
  }
}