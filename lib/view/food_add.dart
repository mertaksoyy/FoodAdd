import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodadd/model/food_note/food_note_dao.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key, required this.title});

  final String title;

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {

  

  Future<void> addNoteOnPress(String foodName, String restName, double rating) async {
    String category = widget.title.toLowerCase().replaceAll(' ', '');

    await FoodsDao().addFoodNote(category, foodName, restName, rating);
  }

  var tfFoodName = TextEditingController();
  var tfRestName = TextEditingController();
  double rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, 
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ), 

        title: Text(
          "Add to ${widget.title}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),

      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    addNoteOnPress(tfFoodName.text, tfRestName.text, rating);

                    Navigator.of(context).pop();
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: const [
                      Icon(Icons.add, size: 30,),

                      SizedBox(width: 5,),

                      Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]
                  )
                )
              )
            ],
          )
        )
      ),
    );
  }
}