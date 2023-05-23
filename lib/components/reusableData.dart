// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class reusableData {
      //---Firebase initualise---
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController date = TextEditingController();

  //---declare conceptiondate variable---
  late String conceptionDate;

  late String userUID;

  //---funtion to fet user uid from firebase---
  String getUserUID() {
   final user = auth.currentUser;
   userUID = user!.uid;
   return userUID;
  }
}