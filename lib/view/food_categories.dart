import 'package:flutter/material.dart';

import 'package:foodadd/view/category_detail.dart';

class FoodCategories extends StatelessWidget {
  const FoodCategories({super.key});

  static const List<String> categories = [
    "Main Courses", "Soups", "Hamburgers", "Salads", "Drinks", "Desserts"
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,

          crossAxisCount: 2,
          childAspectRatio: 1,
        ),

        delegate: SliverChildBuilderDelegate(
          childCount: categories.length,

          (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => CategoryDetail(title: categories[index],)
                  )
                );
              },
              child: FoodCategoryCard(
                title: categories[index],
              ),
            );
          },
        ),
      )
    );
  }
}

class FoodCategoryCard extends StatelessWidget {
  const FoodCategoryCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Image.asset(
              "images/${title.toLowerCase().replaceAll(' ', '')}.png",
              width: 80,
              height: 80,
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ),
        ],
      ),
    );
  }
}
