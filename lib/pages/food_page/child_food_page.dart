// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:natal_nurture_1/pages/home/child_page.dart';
import 'package:natal_nurture_1/pages/home/navigator.dart';

class ChildFoodPage extends StatelessWidget {
  const ChildFoodPage({super.key, required this.index, required this.todayFoods});

  final int index;
  final List todayFoods;

  String getFoodName (List todayFoods)
  {
    return todayFoods[index];
  }

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

  // function to get the image
  String getfoodImage(foodName) {
    if (foodName == 'Pancakes') {
      return "images/food_images/pancakes.png";
    }
    else if (foodName == 'Brunch style eggs') {
      return "images/food_images/brunch_style_eggs.png";
    }
    else if (foodName == 'Smoothie') {
      return "images/food_images/snoothie.png";
    }
    else if (foodName == 'Muffins') {
      return "images/food_images/muffins.png";
    }
    else if (foodName == 'Cereal') {
      return "images/food_images/cereal.png";
    }
    else if (foodName == 'Whole grain toast') {
      return "images/food_images/whole_grain_toast.png";
    }
    else if (foodName == 'Chicken and rice') {
      return "images/food_images/chicken_and_rice.png";
    }
    else if (foodName == 'Pork and rice') {
      return "images/food_images/pork_and_rice.png";
    }
    else if (foodName == 'Beef') {
      return "images/food_images/beef.png";
    }
    else if (foodName == 'Bananas') {
      return "images/food_images/banana.png";
    }
    else if (foodName == 'Scrambled eggs') {
      return "images/food_images/scrambled_eggs.png";
    }
    else if (foodName == 'Sandwich') {
      return "images/food_images/sandwich.png";
    }
    else if (foodName == 'Fried rice') {
      return "images/food_images/fried_rice.png";
    }
    else if (foodName == 'Chicken salad') {
      return "images/food_images/chicken_salad.png";
    }
    else if (foodName == 'Egg salad') {
      return "images/food_images/egg_salad.png";
    }
    else if (foodName == 'Pasta') {
      return "images/food_images/pasta.png";
    }
    else if (foodName == 'Banana muffins') {
      return "images/food_images/banana_muffins.png";
    }
    return "images/failed.png";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        title: Text(getTodayPeriod(index), style: TextStyle(color: Colors.black),),
        leading: Container(child:  
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorPage()));}, icon: Icon(Icons.arrow_back_rounded, color: Colors.black,), )
        ),
        automaticallyImplyLeading: false,
      ),
      
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 320,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    getfoodImage(getFoodName(todayFoods)),
                  )
                )
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 300,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Color.fromARGB(255, 243, 242, 242),
              ),
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFoodName(todayFoods),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 10,),

                    Divider(color: Colors.grey,),

                    SizedBox(height: 20,),
                    
                    Container(
                      child: Text("Description: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    
                    SizedBox(height: 25,),

                    Container(
                      child: Text(""),
                    )
                  ]
                ),
              ),
            )
            
          )
        ],
      ),
    );
  }
}