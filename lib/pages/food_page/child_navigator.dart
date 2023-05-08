import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/food_page/child_food_page.dart';

class ChildNavigator extends StatefulWidget {
  const ChildNavigator({super.key, required this.todayFoods});

  final List todayFoods;
  @override
  State<ChildNavigator> createState() => _ChildNavigatorState();
  
}

class _ChildNavigatorState extends State<ChildNavigator> {
  // Firebase initualise
  final FirebaseAuth auth = FirebaseAuth.instance;

  late String userUID;
  

  //funtion to fet user uid from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }
  
  Future<List> getTodayFoods() async {
    //get current food documebt
    DocumentSnapshot document = await FirebaseFirestore.instance.collection("todayFoods").doc(getUserUID()).get();
    // get today food fied
    List todayFoods = document["todayFoods"];
    return todayFoods;
  }
  
  int currentIndex = 0;
  Future<List> screens = [
    ChildFoodPage(index: 0, todayFoods: returnToday),
    ChildFoodPage(index: 0, todayFoods: todayFoods),
    ChildFoodPage(index: 0, todayFoods: todayFoods),
  ] as Future<List>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index) ,
        items: [   
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.woman),
            label: "Pregnant",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: "Children",
            
          )
        ]
      ),
    );


  }
}