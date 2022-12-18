import 'package:flutter/material.dart';

import 'package:foodadd/view/food_categories.dart';
import 'package:foodadd/view/social.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const List<String> categories = [
    "Main Courses", "Soups", "Hamburgers", "Salads", "Drinks", "Desserts"
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget body = Container();

    switch (_index) {
      case 0:
        body = const FoodCategories();
        break;

      case 1:
        body = const SocialPage();
        break;
    }
  
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            shadowColor: Colors.black,
            elevation: 2,

            pinned: true,
            snap: true,
            floating: true,

            backgroundColor: Colors.white,//Theme.of(context).dividerColor,

            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "FoodAdd", 
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              //background: Image.asset("images/foodadd_logo.png"),
            ),
            expandedHeight: 120,
          ),

          body,
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
  
        iconSize: 40,
  
        showSelectedLabels: false,
        showUnselectedLabels: false,
  
        backgroundColor: const Color(0xff303030),

        currentIndex: _index,

        onTap: (index) => setState(() => _index = index),
  
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "",),
  
          BottomNavigationBarItem(icon: Icon(Icons.share),label: "",),
        ]
      ),
      
    );
  }
}