import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:natal_nurture_1/pages/home/home_page.dart';

class ChildFoodPage extends StatelessWidget {
  const ChildFoodPage({super.key, required this.index, required this.todayFoods});

  final int index;
  final List todayFoods;

  String getTodayPeriod(int index)
  {
    if (index == 0)
    {
      return "Breakfast";
    }
    else if (index == 1)
    {
      return "Lunch";
    }
    else if (index == 2)
    {
      return "Dinner";
    }
    return "Unable to load time";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        title: Text(getTodayPeriod(index), style: TextStyle(color: Colors.black),),
        leading: Container(child:  
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));}, icon: Icon(Icons.arrow_back_rounded, color: Colors.black,), )
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text(todayFoods[index]),
            )
          ]
        ),
      ),
    );
  }
}