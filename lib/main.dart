import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:foodadd/view/home_page.dart';


List posts = [
  {"title":"Hamburger", "image":"images/hamburgers.png", "author":"Ali", "rating":5.0},
  {"title":"Salad", "image":"images/salads.png", "author":"Mert", "rating":3.5},
  {"title":"Drink", "image":"images/drinks.png", "author":"Mehmet Lütfi", "rating":4.0},
];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodAdd',
      home: const HomePage(),

      theme: ThemeData(
        // Star color
        indicatorColor: Colors.amber,
        // Primary green color
        primaryColor: const Color(0xffE4EFCD),
        // Card dark green color
        cardColor: const Color.fromARGB(255, 210, 234, 158),
        dividerColor: const Color(0xff505050),

        inputDecorationTheme: const InputDecorationTheme(

          labelStyle: TextStyle(
            color: Color(0xff303030),
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),

          iconColor: Color(0xff505050),

          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff303030),),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff505050),),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

        ),

        textTheme: const TextTheme(

          // AppBar title
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),

          // Food add
          titleMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),

          // Main page food title
          // Social postcard name title
          labelMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          // Postcard food title
          bodyMedium: TextStyle(
            fontSize: 25,
          ),

        ),

      ),

    );
  }
}

