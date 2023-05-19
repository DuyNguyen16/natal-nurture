
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/components/reusableData.dart';
import 'package:natal_nurture_1/pages/boarding_page.dart';
import 'package:natal_nurture_1/pages/main_pages/navigator.dart';


class AuthPage2 extends StatefulWidget {
  AuthPage2({super.key});
  @override
  
  State<AuthPage2> createState() => _AuthPage2State();
  
}

class _AuthPage2State extends State<AuthPage2> {
      //---Firebase initualise---
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userUID;

  //---funtion to fet user uid from firebase---
  String getUserUID() {
   final user = auth.currentUser;
   userUID = user!.uid;
   return userUID;
  }
  @override
  
  //---function that check if the user document exist---
  Future<bool> documentExist(String userUID) async {
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore.instance.collection("users").doc(userUID).get();

    if (document.exists)
    {
      return true;
    }
    else
    {
      return false;
    }
  } 

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return  NavigatorPage();
              } 
              else {
                return  OnBoardingPage();
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
          future: documentExist(getUserUID()),
        ),
      ),
    );
  }
}