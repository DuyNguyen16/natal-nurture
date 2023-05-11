// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:natal_nurture_1/components/my_button.dart';
import 'package:natal_nurture_1/pages/random/classes.dart';
import 'package:natal_nurture_1/pages/main_pages/navigator.dart';
import 'package:natal_nurture_1/pages/Setting_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  // firebase auth
  final FirebaseAuth auth = FirebaseAuth.instance;
  // page controller
  final page_controller = PageController();
  // text editing controller to get data from input textfield
  final controller = TextEditingController();
  // user id
  late String userUID;

  // declear conceptiondate variable
  late String selectedDate;

  // allergies list
  List<String> userAllergies = [];

  void ShowMultiSelect() async {

    // list of allergies for user to select from
    final List<String> allergies = [
      'dairy',
      'egg',
      'fruits',
      'legumes',
      'soy',
      'seafood',
      'meat',
      'potato',
      'vegetable'
    ];

    // result after the user select the allergies
    final List<String>? results = await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return MultiSelect(allergies: allergies);
      }
    );

    // update the userAllergies to the result that the user selected
    if (results != null) {
      setState(() {
        userAllergies = results;
      });
    }
  }


  //funtion to fetch user id from firebase  
  String getUserUID() {
   final user = auth.currentUser;
   
   userUID = user!.uid;
   return userUID;
  }




  void enterConceptionDateMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.pinkAccent,
          title: Text(
            'Please select a date of conception',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  // date controller
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          // page view controller to change pages
          controller: page_controller,
          children: [

            // ========================= BEGIN PAGE 1 =======================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 140),
                          Container(
                            child: Text(
                              "Welcome!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.pinkAccent,
                              
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Container(
                            
                            width: 300,
                            child: Text(
                              "Natal Nurture is a pregnancy app that provides users with informations on what to to eat during their pregnacy.",
                              style: TextStyle(
                                color: Colors.white, 
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                          
                            ),
                          ),

                          SizedBox(height: 90),

                          MyButton(onTap: () => page_controller.jumpToPage(1), text: "Let's get started!"),
                          
                          SizedBox(height: 228),

                          Container(
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: page_controller,
                                count: 4,
                                effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ========================= END PAGE 1 ===============================

            // ========================== BEGIN PAGE 2 ============================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 150),

                          Container(
                            child: Text(
                              "Date of conception",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.pinkAccent,
                              
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Container(child: 
                            Text(
                              'Please select your date of conception',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 20),
                        
                          Container(
                            width: 330,
                            child: TextField(
                              
                              controller: date,
                              decoration: InputDecoration(
                                enabledBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 225, 107, 107))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Select",
                                prefixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              onTap: () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), 
                                  firstDate: DateTime(2022, ), 
                                  lastDate: DateTime.now());

                                  if (pickeddate != null) {
                                    setState(() {
                                      date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                                    });
                                  }
                                
                              },
                            ),
                          ),

                          SizedBox(height: 15),

                          MyButton(onTap: () => page_controller.jumpToPage(2), text: "Next"),

                          SizedBox(height: 8),

                          TextButton(onPressed: () => {page_controller.jumpToPage(0)}, child: Text("Back")),

                          SizedBox(height: 222),

                          Center(
                            child: SmoothPageIndicator(
                              controller: page_controller,
                              count: 4,
                              effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ========================== END PAGE 2 ============================


            // =========================== BEGIN PAGE 3 =========================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(height: 100),

                          Text(
                            "Allergies Selection",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 260,
                              child: Text(
                                "Please select foods that you're allergies to, so that we can ensure the foods we recommned don't contains them.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ),
                          ),


                          SizedBox(height: 30),

                          MyButton(
                            onTap: ShowMultiSelect,
                            text: "Select your allergies"
                          ),
                          
                          SizedBox(height: 10),

                          MyButton(onTap: () => {page_controller.jumpToPage(3)}, text: "Next",
                          ),

                          TextButton(onPressed: () => {page_controller.jumpToPage(1)}, child: Text("Back")),
                          
                          const Divider(height: 30),

                          Text(
                            "Allergies selected: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            children: userAllergies.map((allergy) => Chip(
                              label: Text(allergy),
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              ),
                            )).toList(),
                          ),

                          SizedBox(height: 145),

                          Center(
                            child: SmoothPageIndicator(
                              controller: page_controller,
                              count: 4,
                              effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                            ),
                          )
                        ],
                        
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // =========================== END PAGE 3 =================================



            // ============================ BEGIN PAGE 4 ==============================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/background.png"
                  ),
                  fit: BoxFit.cover,
                )
              ),
      
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                      
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SizedBox(height: 160),

                          Text(
                            "You're all set!",
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),

                          SizedBox(height: 10),

                          Container(
                            width: 260,
                            child: Text(
                              "You can change these in the setting anytime",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                
                              ),
                            ),
                          ),

                          
                          SizedBox(height: 60,),

                          MyButton(
                            onTap: () async{
                              
                              // check if user select date of conception
                              if (date.text == "")
                              {
                                  enterConceptionDateMessage();
                                  page_controller.jumpToPage(1);
                              }
                              else
                              {
                                DocumentSnapshot document = await FirebaseFirestore.instance.collection('foods').doc("food-id").get();
                                Map recommendedFood = document["recFoods"];
                                    


                                selectedDate = date.text;
                                final userUID = getUserUID();

                                  // loop through every items in userAllergies list
                                  userAllergies.forEach((item) {
                                    // remove the items at the recommended food map
                                    recommendedFood.remove(item);
                                  },);

                                  createUser(selectedDate: selectedDate, userUID: userUID, userAllergies: userAllergies, recommendedFood: recommendedFood); 
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => NavigatorPage()));
                              }
                            },
                            
                            text: "Done!",
                          ),

                          TextButton(onPressed: () => {page_controller.jumpToPage(2)}, child: Text("Back")),
                          
                          SizedBox(height: 220),
                          
                          Center(
                            child: SmoothPageIndicator(
                              controller: page_controller,
                              count: 4,
                              effect: SwapEffect(activeDotColor: Colors.pinkAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ============================ END PAGE 4 ==================================
          ],
        ),
      ),
    );

    
  }
  Future createUser({required String selectedDate, required String userUID, required List userAllergies, required Map recommendedFood}) async {
      // reference to document on firebase
      final UserDoc = FirebaseFirestore.instance.collection('users').doc(getUserUID());
      // name and items to create
      final json = {
        'UserUID': userUID,
        'Date': selectedDate,
        'userAllergies': userAllergies,
        "recommendedFood": recommendedFood,
      };
      await UserDoc.set(json);
  }
}

