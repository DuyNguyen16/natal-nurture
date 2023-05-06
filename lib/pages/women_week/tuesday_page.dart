// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/home/home_page.dart';
import 'package:natal_nurture_1/pages/data/food_rec.dart';

class TuesPage extends StatefulWidget {
  const TuesPage({super.key});

  @override
  State<TuesPage> createState() => _TuesPageState();
}

class _TuesPageState extends State<TuesPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        leading: Container(
        child: 
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));}, icon: Icon(Icons.arrow_back_rounded))
        ),
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Container(
          child: Column(children: [
            FoodRec(),
            
            ]),
        ),
      ),
    );
  }
}