// ignore_for_file: prefer_const_constructors

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/pages/main_pages/home_page.dart';
import 'package:natal_nurture_1/pages/main_pages/navigator.dart';
import 'package:natal_nurture_1/pages/random/classes.dart';

import 'auth_page.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  late String userUID;
  //funtion to fet user uid from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }
  //---changing user allergies function---
  void changeAllergies() async {
    DocumentSnapshot foodDocument = await FirebaseFirestore.instance.collection('foods').doc("food-id").get();
    Map recommendedFood = foodDocument["recFoods"];
    
    //---loop through every items in userAllergies list---
    userAllergies.forEach((item) {
      //---remove the items at the recommended food map---
      recommendedFood.remove(item);
    },);
    //---update data---
    FirebaseFirestore.instance.collection('users').doc(getUserUID()).update({
      "userAllergies" : userAllergies,
      "recommendedFood" : recommendedFood,
    });
  }

  //---allergies list---
  List<String> userAllergies = [];

  void ShowMultiSelect() async {

    // list of allergies for user to select from
    final List<String> allergies = [
      'dairy',
      'egg',
      'fruits',
      'legumes',
      'soy',
      'seafood',
      'meat',
      'potato',
      'vegetable'
    ];

    //---result after the user select the allergies---
    final List<String>? results = await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return MultiSelect(allergies: allergies);
      }
    );

    //---update the userAllergies to the result that the user selected---
    if (results != null) {
      setState(() {
        userAllergies = results;
      });
    }
  }
  //Sign User out method
    void signUserOut() async{

      FirebaseAuth.instance.signOut();
    }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
      ),
      body: Container(
        //---Background Image---
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/background.png"
            ),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Container(
                  width: 300,
                  child: Text(
                    'If you want to change your allergies please press "Select your allergies" first before pressing change, even if you wanted to clear allergy',
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  )
                ),

                SizedBox(height: 40,),

                MyButton(
                  onTap: ShowMultiSelect,
                  text: "Select your allergies"
                ),

                SizedBox(height: 10,),

                MyButton(
                  onTap: () {
                    changeAllergies();  
                    // show dialog that successfully change allergies
                    Flushbar(
                      margin: EdgeInsets.only(top: 5),
                      borderRadius: BorderRadius.circular(10),
                      maxWidth: 250,
                      icon: Icon(Icons.check, color: Colors.pinkAccent, size: 25,),
                      message: "Successfully changed allergies",
                      messageText: Text("Successfully changed your allergies", style: TextStyle(fontSize: 16.0, color: Colors.pinkAccent,), textAlign: TextAlign.center,),
                      duration: Duration(milliseconds: 2200),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Colors.white,
                    ).show(context);
                  }, 
                  text: "Change"
                ),
                
                SizedBox(height: 110,),

                TextButton(
                  onPressed: () {
                    signUserOut(); 
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
                  }, 
                  child: Text("Sign Out", style: TextStyle(fontSize: 25),)
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}