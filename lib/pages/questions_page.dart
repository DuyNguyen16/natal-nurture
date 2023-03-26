import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List recommendedFoodList = ["Ramen","Egg","Meat","Whey"];

  removeAllergies(userAllergies,recommendedFoodList) {
        
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Welcome to Natal Nurture",
                style: TextStyle(color: Colors.white),
              )
            ]
          ),
        )
      ),
    );
  }
}