// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/components/my_multi_select.dart';
import 'package:natal_nurture_1/components/reusableData.dart';
import 'auth_page.dart';

//---called in reusableData class to access to reusable data types---
reusableData data = reusableData();

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  //---function to remove user allergies from food recommendation list---
  removeAllergies(Map foodRecommendation, List userAllergies) {
    //---loop through every items in userAllergies list---
    userAllergies.forEach((item) {
      //---remove the items at the recommended food map---
      foodRecommendation.remove(item);
    });
    return foodRecommendation;
  }

  //---changing user allergies function---
  void changeAllergies() async {
    DocumentSnapshot foodDocument = await FirebaseFirestore.instance.collection('foods').doc("food-id").get();
    Map recommendedFood = removeAllergies(foodDocument["recFoods"], userAllergies);
    //---update data---
    FirebaseFirestore.instance.collection('users').doc(data.userUID).update({
      "userAllergies" : userAllergies,
      "recommendedFood" : recommendedFood,
    });
  }

  //---allergies list---
  List<String> userAllergies = [];

  void showMultiSelect() async {

    //---list of allergies for user to select from---
    final List<String> allergies = [
      'dairy',
      'egg',
      'fruits',
      'legumes',
      'soy',
      'meat',
      'potato',
      'vegetable'
    ];

    //---result after the user select the allergies---
    final List<String>? results = await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return MyMultiSelect(allergies: allergies);
      }
    );

    //---update the userAllergies to the result that the user selected---
    if (results != null) {
      setState(() {
        userAllergies = results;
      });
    }
  }
  //---Sign User out method---
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
                SizedBox(height: 80,),

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
                  onTap: showMultiSelect,
                  text: "Select your allergies"
                ),

                SizedBox(height: 10,),

                MyButton(
                  onTap: () {
                    changeAllergies();  
                    //---show dialog that successfully change allergies---
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
                
                SizedBox(height: 20,),

                Text(
                  "Allergies selected: ",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                Container(
                  width: 340,
                  child: Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: userAllergies.map((allergy) => Chip(
                        label: Text(allergy),
                          labelStyle: TextStyle(
                            color: Colors.pinkAccent,
                            backgroundColor: Colors.white,
                          ),
                            backgroundColor: Colors.white,
                        )).toList(),
                        alignment: WrapAlignment.center,
                    ),
                  ),    
                ),
                
                SizedBox(height: 60,),

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