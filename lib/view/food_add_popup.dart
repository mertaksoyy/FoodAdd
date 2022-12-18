import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';

import 'package:foodadd/model/food_note/food_note_dao.dart';


class FoodAddDialog extends StatefulWidget {
  const FoodAddDialog({super.key, required this.category, this.food});

  final String category;
  final FoodNote? food;

  @override
  State<FoodAddDialog> createState() => _FoodAddDialogState();
}

class _FoodAddDialogState extends State<FoodAddDialog> {

  Future<void> addNoteOnPress(String category, String foodName, String restName, double rating) async {
    await FoodsDao().addFoodNote(category, foodName, restName, rating);
  }

  Future<void> updateNoteOnPress(int foodID, String category, String foodName, String restName, double rating) async {
    await FoodsDao().foodUpdate(foodID, category, foodName, restName, rating);
  }

  Future<void> deleteFoodOnPress(int foodID) async{
    await FoodsDao().foodDelete(foodID);
  }

  @override
  Widget build(BuildContext context) {
    var tfFoodName = TextEditingController();
    var tfRestName = TextEditingController();
    double rating = 4.5;
    bool update = false;

    if (widget.food != null) {
      tfFoodName.text = widget.food!.foodName;
      tfRestName.text = widget.food!.restName;
      rating = widget.food!.rating;

      update = true;
    }

    

    return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30,),

            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.no_food_outlined),
                labelText: "Food Name",
                hintText: "Name",
              ),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              controller: tfFoodName,
            ),

            const SizedBox(height: 30,),

            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.food_bank_outlined, size: 30,),
                labelText: "Restaurant Name",
                hintText: "Restaurant",
              ),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              controller: tfRestName,
            ),

            const SizedBox(height: 40,),

            RatingBar.builder(
              glow: false,
              initialRating: rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),

              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).indicatorColor,
                size: 40,
              ),

              onRatingUpdate: (r) {
                rating = r;
              },
            ),

            const SizedBox(height: 40,),

            SizedBox(
              width: 150,
              height: 40,

              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xff303030)),
                ),

                onPressed:() {
                  if (update){
                    updateNoteOnPress(widget.food!.foodID, widget.category, tfFoodName.text, tfRestName.text, rating);
                  } else {
                    addNoteOnPress(widget.category, tfFoodName.text, tfRestName.text, rating);
                  }
                  
                  Navigator.of(context).pop();
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      (update) ? Icons.update : Icons.add, 
                      size: 30,
                    ),

                    const SizedBox(width: 5,),

                    Text(
                      (update) ? "Update" : "Add",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 15,),

            (update) ? SizedBox(
              width: 120,
              height: 40,

              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xff303030)),
                ),

                onPressed:() {
                  deleteFoodOnPress(widget.food!.foodID);
                  
                  Navigator.of(context).pop();
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete,
                      size: 20,
                    ),

                    SizedBox(width: 5,),

                    Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]
                )
              )
            ) : Container(),


          ],
        )
      );
  }
}