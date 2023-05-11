// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/Setting_page.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:natal_nurture_1/pages/home/home_page.dart';
import 'package:natal_nurture_1/pages/home/pregnant_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});
  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
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
          IconButton(onPressed: () {
            Navigator.push(
              context, 
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => SettingsPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }, icon: Icon(Icons.settings))
        ],
        automaticallyImplyLeading: false,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index) ,
        items: [   
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            
          ),
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