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
    return "Unable";
  }

  // function to get the image
  String getFoodImage(foodName) {
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

  // function to get the food description
  String getFoodDescription(foodName) {
    if (foodName == 'Pancakes') {
      return "186 calories, 4 grams of protein, 30 grams of carbohydrate, 1 gram of fiber, and 5 grams of sugar.";
    }
    else if (foodName == 'Brunch style eggs') {
      return "";
    }
    else if (foodName == 'Smoothie') {
      return "Smoothies can be a great way to increase intakes of fruit and vegetables in our diet, which would have many health benefits.";
    }
    else if (foodName == 'Muffins') {
      return "Muffin provides 209 calories, 8 grams of protein, 41 grams of carbohydrate, 3 grams of dietary fiber, 3 grams sugar, 2 grams of fat and 391 milligrams of sodium.";
    }
    else if (foodName == 'Cereal') {
      return "Cereal is a good source of protein, a good source of B vitamins, including folate. Many minerals, including iron, magnesium, copper, phosphorus, and zinc, can be found in it.";
    }
    else if (foodName == 'Whole grain toast') {
      return "Consuming whole grain bread decreases total cholesterol, LDL cholesterol, triglycerides, and insulin levels.";
    }
    else if (foodName == 'Chicken and rice') {
      return "Benefits of eating chicken and rice is that it packed with protein and carbs, increases muscle mass, improves bone health and boost immunity.";
    }
    else if (foodName == 'Pork and rice') {
      return "Benefits of eating pork and rice is that it provides vitamins B12, B6 that helps immune system to work normally.";
    }
    else if (foodName == 'Beef') {
      return "Beef is rich in protein which helps muscle growth and supports muscle mass.";
    }
    else if (foodName == 'Bananas') {
      return "Bananas provides potassium which helps your body maintain a healthy heart and blood pressure.";
    }
    else if (foodName == 'Scrambled eggs') {
      return "Eggs that are scrambled are a wonderful source of protein. They are a fantastic source of essential nutrients, including vitamin B6, B12, and vitamin D, and they also contain heart-healthy unsaturated fats.";
    }
    else if (foodName == 'Sandwich') {
      return "Sandwiches offer lean protein, fiber-rich vegetables, healthy fats, and complex carbohydrates.";
    }
    else if (foodName == 'Fried rice') {
      return "Fried rice contains chopped vegetables, which are high in fibre, vitamins, and minerals, all of which are necessary for proper bodily function.";
    }
    else if (foodName == 'Chicken salad') {
      return "Chicken salad is rich in lean protein and a decent source of iron.";
    }
    else if (foodName == 'Egg salad') {
      return "Egg salad is good for your body as it provides a lot of proteins.";
    }
    else if (foodName == 'Pasta') {
      return "Pasta is a good source of energy and it also can help with stomach problems and may help lower cholesterol.";
    }
    else if (foodName == 'Banana muffins') {
      return "Bananas are high in fibre and antioxidants, and the other ingredients in the dish are healthier.";
    }
    return "unable to load description";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        title: Text(getTodayPeriod(index), style: TextStyle(color: Colors.black),),
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
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
                    getFoodImage(getFoodName(todayFoods)),
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
                      child: Text(getFoodDescription(getFoodName(todayFoods)), style: TextStyle(fontSize: 15),),
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