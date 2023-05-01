import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/background.png"
              ),
            fit: BoxFit.cover,
            )
          ),
          ),
          Container(color: Colors.green),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}