
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natal_nurture_1/pages/main_pages/navigator.dart';


class FoodPage extends StatelessWidget {
  FoodPage({super.key, required this.index, required this.thisWeekFood});
  // function to get the current day food name
  String getFoodName (List thisWeekFood)
  {
    return thisWeekFood[index];
  }

  // function to get the image
  String getFoodDescription(foodName) {
    if (foodName == 'Milk') {
      return "Milk is high in calcium and protein and should be included in the pregnant woman's diet. Calcium is especially vital during pregnancy for assisting the growing infant in developing strong bones.";
    }
    else if (foodName == 'Cheese') {
      return "Cheese is high in calcium and can be consumed as part of a healthy, balanced diet.";
    }
    else if (foodName == 'Yogurt') {
      return "Yoghurt is high in calcium, which is essential for your baby's bone and tooth development, as well as heart, neurone, and muscle function.";
    }
    else if (foodName == 'Egg') {
      return "Eggs include a number of vitamins, including vitamin A, which aids in the healthy development of the eyes and skin as well as the immune system. They also include crucial pregnancy nutrients including iodine, folate, and iron. Infant growth and development require it.";
    }
    else if (foodName == 'Apple') {
      return "Apples are high in nutrients that can benefit a growing foetus, including vitamins A and C, fibre, and potassium.";
    }
    else if (foodName == 'Oranges') {
      return "Oranges contains Vitamin C that help support the baby's growth and improves iron absorption.";
    }
    else if (foodName == 'Mangoes') {
      return "Numerous elements found in mangoes are advantageous to expectant mothers. A serving of mango contains a significant amount of the essential prenatal vitamin folate.";
    }
    else if (foodName == 'Avocados') {
      return "Avocados are packed with good fats that are beneficial for pregnant women.";
    }
    else if (foodName == 'Lemons') {
      return "Lemons are a rich source of nutrients, vitamins, and minerals that assist both mother and child health.";
    }
    else if (foodName == 'Bananas') {
      return "Bananas are a great source of carbohydrates and will offer pregnant ladies the energy they need at this time.";
    }
    else if (foodName == 'Berries') {
      return "Berries are high in vitamin C, antioxidants, fiber, potassium and folate.";
    }
    else if (foodName == 'Lentils') {
      return "Lentils contains folic acid, which is an important nutrient for pregnant women to take.";
    }
    else if (foodName == 'Peas') {
      return "Green peas are a good source of folate, which is crucial for expectant mothers since it guards against neural tube defects that affect the baby's spine and brain development.";
    }
    else if (foodName == 'Beans') {
      return "Beans include folic acid, which is essential for expectant mothers as it lowers the risk of spinal cord birth abnormalities.";
    }
    else if (foodName == 'Chickpeas') {
      return "Chickpeas are an excellent source of iron, folate, potassium, protein, and fibre during pregnancy.";
    }
    else if (foodName == 'Lean beef') {
      return "Lean beef is a fantastic source of high-quality protein.";
    }
    else if (foodName == 'Pork') {
      return "Pork is a fantastic source of high-quality protein.";
    }
    else if (foodName == 'Chicken') {
      return "Chicken is a fantastic source of high-quality protein.";
    }
    else if (foodName == 'Sweet potato') {
      return "Sweet potatoes are a nutritious and delightful pregnant food. ";
    }
    else if (foodName == 'Broccoli') {
      return "Broccoli provides vitamin C, which is a substance that is considered vital for pregnant health.";
    }
    else if (foodName == 'Kale') {
      return "Kale is high in calcium, iron, and folic acid, as well as other essential vitamins.";
    }
    else if (foodName == 'Spinach') {
      return "Spinach is high in calcium, iron, and folic acid, as well as other essential vitamins.";
    }
    return "Unable to load description";
  }

  // function to get the image
  String getFoodImage(foodName) {
    if (foodName == 'Milk') {
      return "images/food_images/milk.png";
    }
    else if (foodName == 'Cheese') {
      return "images/food_images/cheese.png";
    }
    else if (foodName == 'Yogurt') {
      return "images/food_images/yugurt.png";
    }
    else if (foodName == 'Egg') {
      return "images/food_images/egg.png";
    }
    else if (foodName == 'Apples') {
      return "images/food_images/apple.png";
    }
    else if (foodName == 'Oranges') {
      return "images/food_images/orange.png";
    }
    else if (foodName == 'Mangoes') {
      return "images/food_images/mangoes.png";
    }
    else if (foodName == 'Avocados') {
      return "images/food_images/avocados.png";
    }
    else if (foodName == 'Lemons') {
      return "images/food_images/lemon.png";
    }
    else if (foodName == 'Bananas') {
      return "images/food_images/banana.png";
    }
    else if (foodName == 'Berries') {
      return "images/food_images/berries.png";
    }
    else if (foodName == 'Lentils') {
      return "images/food_images/lentils.png";
    }
    else if (foodName == 'Peas') {
      return "images/food_images/peas.png";
    }
    else if (foodName == 'Beans') {
      return "images/food_images/beans.png";
    }
    else if (foodName == 'Chickpeas') {
      return "images/food_images/chickpea.png";
    }
    else if (foodName == 'Lean beef') {
      return "images/food_images/lean_beef.png";
    }
    else if (foodName == 'Pork') {
      return "images/food_images/pork.png";
    }
    else if (foodName == 'Chicken') {
      return "images/food_images/chicken.png";
    }
    else if (foodName == 'Sweet potato') {
      return "images/food_images/sweet_potato.png";
    }
    else if (foodName == 'Broccoli') {
      return "images/food_images/broccoli.png";
    }
    else if (foodName == 'Kale') {
      return "images/food_images/kale.png";
    }
    else if (foodName == 'Spinach') {
      return "images/food_images/spinach.png";
    }
    return "images/failed.png";
  }
  // Firebase initualise
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userUID;
  
  //funtion to fet user uid from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }

  String getWeekDay(int index) 
  {
    if (index == 0)
    {
      return 'Monday';
    }
    else if (index == 1)
    {
      return 'Tuesday';
    }
    else if (index == 2)
    {
      return 'Wednesday';
    }
    else if (index == 3)
    {
      return 'Thursday';
    }
    else if (index == 4)
    {
      return 'Friday';
    }
    else if (index == 5)
    {
      return'Saturday';
    }
    return 'Sunday';
  }

  final int index;
  final List thisWeekFood;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 190, 1),
        title: Text(getWeekDay(index), style: TextStyle(color: Colors.black),),
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
                    getFoodImage(
                      getFoodName(thisWeekFood)
                    )
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
                    // food name
                    Text(
                      getFoodName(thisWeekFood),
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
                      child: Text("Description: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    
                    SizedBox(height: 25,),

                    Container(
                      child: Text(getFoodDescription(getFoodName(thisWeekFood)), style: TextStyle(fontSize: 15),),
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