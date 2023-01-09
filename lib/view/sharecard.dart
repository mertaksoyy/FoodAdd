import 'package:flutter/material.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ShareCard extends StatelessWidget {
  const ShareCard({super.key, required this.food});

  final FoodNote food;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(food.foodName),
          Text(food.restName),
          RatingBarIndicator(
            rating: food.rating,
            itemCount: 5,
            itemSize: 25,

            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}