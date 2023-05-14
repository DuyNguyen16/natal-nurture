// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class reusableData {
  //---Firebase initualise---
  final FirebaseAuth auth = FirebaseAuth.instance;
  //--current user---
  final user = FirebaseAuth.instance.currentUser!;
  //---userUID---
  String userUID = FirebaseAuth.instance.currentUser!.uid;
  //---user email---
  final userEmail = TextEditingController();
  //---user password---
  final userPassword = TextEditingController();
  //---user password confirmation---
  final userPasswordConfirm = TextEditingController();
  //---date controller---
  TextEditingController date = TextEditingController();
}