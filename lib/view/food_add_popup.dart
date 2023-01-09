import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';

import 'package:foodadd/model/food_note/food_note_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:share_plus/share_plus.dart';

import 'dart:io';


class FoodAddDialog extends StatefulWidget {
  const FoodAddDialog({super.key, required this.category, this.food});

  final String category;
  final FoodNote? food;

  @override
  State<FoodAddDialog> createState() => _FoodAddDialogState();
}

class _FoodAddDialogState extends State<FoodAddDialog> {

  Future<void> addNoteOnPress(String category, String foodName, String restName, double rating,String restAddr) async {
    await FoodsDao().addFoodNote(category, foodName, restName, rating,restAddr);
  }

  Future<void> updateNoteOnPress(int foodID, String category, String foodName, String restName, double rating,String restAddr) async {
    await FoodsDao().foodUpdate(foodID, category, foodName, restName, rating,restAddr);
  }

  Future<void> deleteFoodOnPress(int foodID) async{
    await FoodsDao().foodDelete(foodID);
  }


  @override
  Widget build(BuildContext context) {
    var tfFoodName = TextEditingController();
    var tfRestName = TextEditingController();
    var tfRestAddr = TextEditingController();
    double rating = 4.5;
    bool update = false;

    if (widget.food != null) {
      tfFoodName.text = widget.food!.foodName;
      tfRestName.text = widget.food!.restName;
      rating = widget.food!.rating;
      tfRestAddr.text = widget.food!.restAddr;

      update = true;
    }


    return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [


            Padding(
              padding: const EdgeInsets.fromLTRB(20,40,20,10),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.food_bank_outlined, size: 30,),
                  labelText: "Food Name",
                  hintText: "Food",
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
                controller: tfFoodName,
              ),
            ),



            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              child: TextFormField(
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
            ),



            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,20),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.food_bank_outlined, size: 30,),
                  labelText: "Restaurant Address",
                  hintText: "Address",
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
                controller:  tfRestAddr,
              ),
            ),



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

            const SizedBox(height: 20,),

            ElevatedButton.icon(
              onPressed: () {
                if (tfFoodName.text.isNotEmpty && tfRestName.text.isNotEmpty){

                  if (update){
                    updateNoteOnPress(widget.food!.foodID, widget.category, tfFoodName.text, tfRestName.text, rating,tfRestAddr.text);
                  } else {
                    addNoteOnPress(widget.category, tfFoodName.text, tfRestName.text, rating,tfRestAddr.text);
                  }
                  
                  Navigator.of(context).pop();
                }
              },

              icon: Icon((update) ? Icons.update : Icons.add, size:30),

              label: Text(
                (update) ? "Update" : "Add", 
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
              ),

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff303030)),
              ),
            ),

            const SizedBox(height: 15,),

            (!update) ? Container() :
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    deleteFoodOnPress(widget.food!.foodID);
                  
                    Navigator.of(context).pop();
                  },

                  icon: const Icon(Icons.delete, size:20),

                  label: const Text(
                    "Delete", 
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                  ),

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff303030)),
                  ),
                ),

                ElevatedButton.icon(
                  icon: const Icon(Icons.share), 
                  label: const Text("Share"),

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff303030)),
                  ),

                  onPressed: () async {
                    final controller = ScreenshotController();
                    final bytes = await controller.captureFromWidget(
                      ShareCard(food: widget.food!),
                    );

                    final directory = await getApplicationDocumentsDirectory();
                    final image = File("${directory.path}/saved.png");
                    image.writeAsBytesSync(bytes);

                    final ximage = XFile(image.path);
                    
                    await Share.shareXFiles([ximage]);
                  }, 
                ),

                ShareCard(food: widget.food!),

                const SizedBox(height: 15,),
              ],
            )
          ],
        )
      );
  }
}

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