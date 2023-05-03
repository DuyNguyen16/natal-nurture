
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:natal_nurture_1/pages/boarding_page.dart';
import 'package:natal_nurture_1/pages/home_page.dart';

class AuthPage2 extends StatefulWidget {
  AuthPage2({super.key});
  @override
  
  State<AuthPage2> createState() => _AuthPage2State();
  
}

class _AuthPage2State extends State<AuthPage2> {
  @override
  final auth = FirebaseAuth.instance;

  // fetching current user uid
  late String userUID;
  String getUserData() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
  return userUID;
  }
  
  // function that check if the user document exist
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
                      return HomePage();
                    }
                    else 
                    {
                      return OnBoardingPage();
                    }
                    
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                future: documentExist(getUserData()),
            ),
      ),
    );
  }
}