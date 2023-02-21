import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    
    //Sign User out method
    void SignUserOut() async{
      FirebaseAuth.instance.signOut();
    }

    return Container(
      //---Background Image---
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/background.png"
          ),
          fit: BoxFit.cover,
        )
      ),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(248, 244, 139, 163),
          actions: [
            IconButton(
              onPressed: SignUserOut, 
              icon: const Icon(Icons.logout),
            )
          ],
        ),

        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGGED IN!" + ' AS: ',
                style: TextStyle(fontSize: 20, color: Colors.white), 
              ),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          )
        ),
        
      )
   );
  }
}