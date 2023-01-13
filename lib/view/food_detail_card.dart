import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:foodadd/model/food_note/food_note_model.dart';



class FoodDetailCard extends StatelessWidget {
  const FoodDetailCard({
    super.key,
    required this.food,
  });

  final FoodNote food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        color: Theme.of(context).primaryColor,

        child:Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(food.foodName, style: const TextStyle(fontSize: 20),),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(food.restName, style: const TextStyle(fontSize: 20),),
                      Text(food.restAddr, style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                ),

                RatingBarIndicator(
                  rating: food.rating,
                  itemCount: 5,
                  itemSize: 25,

                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),

              ],
            ),
              const Positioned(
              child: Icon(Icons.settings),
              bottom: 2.0,
              right: 2.0,
              )
          ],
        ),
      )
    );
  }
}