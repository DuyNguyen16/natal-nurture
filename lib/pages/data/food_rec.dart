// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference user = FirebaseFirestore.instance.collection('recFoods');


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Container(
        child: FutureBuilder<DocumentSnapshot>(
                            
          //Fetching data from the documentId specified food-id
          future: user.doc("foods-id").get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) 
          {
            if (snapshot.connectionState == ConnectionState.done)   
            {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              // get the food map from firebase
              Map foodsList = data["foods"];
              
              
              String item = foodsList["soy"];
      
              return Text(
                item,
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