// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/Setting_page.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:natal_nurture_1/pages/home/pregnant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    PregPage(),
    ChildPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        actions: <Widget> [
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));}, icon: Icon(Icons.settings))
        ],
        automaticallyImplyLeading: false,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index) ,
        items: [   
          BottomNavigationBarItem(
            icon: Icon(Icons.woman),
            label: "Pregnant",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: "Children",
            
          )
        ]
      ),
    );


  }
}