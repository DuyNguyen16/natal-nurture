// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import "dart:math";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class FoodRec extends StatefulWidget {
  const FoodRec({super.key});

  @override
  State<FoodRec> createState() => _FoodRecState();
}

class _FoodRecState extends State<FoodRec> {
  // declearing user from users collection
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  // initualise firebase auth to access daata
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userUID;

  //funtion to fet user data from firebase  
  String getUserData() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }

  item getRandomItem<item>(List<item> foodList) {
    var random = Random().nextInt(foodList.length);
    return foodList[random];
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Container(
        child: FutureBuilder<DocumentSnapshot>(
                            
          //Fetching data from the documentId specified from the user_uid
          future: user.doc(getUserData()).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) 
          {
            if (snapshot.connectionState == ConnectionState.done)   
            {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              // get the food map from firebase
              Map foodsMap = data["recommendedFood"];
              

              List<String> foodList = [];

              foodsMap.forEach((key, value) {
                foodList.add(value);
              },);

              var randomFood = getRandomItem(foodList);
      
              return Text(
                randomFood,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          return Text("Loading");
          },
        ),
      ),
    );
  }
}