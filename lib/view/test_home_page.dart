import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,snap: true,floating: true,
            expandedHeight: 100,

            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                children: const [
                  Text(
                    "FoodAdd", 
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}