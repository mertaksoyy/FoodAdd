import 'package:flutter/material.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart';




class shareCard extends StatelessWidget {
  const shareCard({super.key, required this.food});
  final FoodNote food;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 800,
        height: 1000,
        child: Card(
          color: Color(0xffE4EFCD),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("images/hamburgers.png")),
              SizedBox(height: 20,),

              Text(style:TextStyle(fontSize: 30),"Food Name"),
              Divider(thickness: 7,indent: 50,endIndent: 50,),
              Text(style:TextStyle(fontSize: 50), food.foodName),
              Text(style:TextStyle(fontSize: 30),"Restaurant Name"),
              Divider(thickness: 7,indent: 50,endIndent: 50,),
              Text(style:TextStyle(fontSize: 50), food.restName),
              Divider(thickness: 7,indent: 50,endIndent: 50,),
              RatingBarIndicator(
                rating: food.rating,
                itemCount: 5,
                itemSize: 50,

                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              )
            ],//Childrenın
          ),
        ),
      ),
    );
  }
}

