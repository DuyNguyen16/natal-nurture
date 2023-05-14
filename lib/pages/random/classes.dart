// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import "dart:math";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';





// multiple selecting allergies class
class MultiSelect extends StatefulWidget {

  final List<String> allergies;
  const MultiSelect({Key? key, required this.allergies}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> userAllergies = [];

  void allergiesChange(String allergieValue, bool isSelected)
  {
    setState(() {
      // check if item is selected if yes add item to userAllergies
      if (isSelected) {
        userAllergies.add(allergieValue);
      }
      else {
        userAllergies.remove(allergieValue);
      };

    });
  }

  void cancelSelect() {
    Navigator.pop(context);
  }

  void submitSelect() {
    Navigator.pop(context, userAllergies);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select allergies", style: TextStyle(color: Colors.pinkAccent),),
      content: SingleChildScrollView(
        child: ListBody(
          children: 
            widget.allergies.map((allergy) => CheckboxListTile(
              value: userAllergies.contains(allergy), 
              title: Text(allergy),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => allergiesChange(allergy, isChecked!),
            )).toList()
        ),
      ),
      actions: [
        TextButton(onPressed: cancelSelect, child: Text("Cancel")),
        ElevatedButton(onPressed: submitSelect, child: Text("Submit"))
      ],
    );
  }
}