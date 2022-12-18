import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//import 'package:foodadd/view/food_add.dart';
import 'package:foodadd/view/food_add_popup.dart';

import 'package:foodadd/model/food_note/food_note_dao.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key, required this.title});

  final String title;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {

  String getCategoryName(){
    return widget.title.toLowerCase().replaceAll(' ', '');
  }

  Future<List<FoodNote>> getFoods() async {
    String category = getCategoryName();

    var foods = await FoodsDao().getCategory(category);

    return foods;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<FoodNote>>(
        future : getFoods(),

        builder: (context, snapshot) {

          if (snapshot.hasData){
            List<FoodNote>? foodList = snapshot.data;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  forceElevated: true,
                  shadowColor: Colors.black,
                  elevation: 2,

                  expandedHeight: 100,

                  pinned: true,
                  snap: true,
                  floating: true,

                  backgroundColor: Colors.white,

                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new, 
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ), 

                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.title, 
                      textScaleFactor: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),

                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),

                  delegate: SliverChildBuilderDelegate(
                    childCount: foodList!.length,

                    (context, index) {
                      FoodNote food = foodList[index];
                      return GestureDetector(
                        child: FoodDetailCard(food: food,),
                        onTap: () async{

                          await showDialog(
                            context: context, 
                            builder: (context) {
                              return FoodAddDialog(category: getCategoryName(), food: food,);
                            }
                          );

                          setState(() {});
                        },
                      );
                    }
                  )
                ),
              ],
            );

          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff303030),
        onPressed: () async {
          await showDialog(
            context: context, 
            builder: (context) {
              return FoodAddDialog(category: getCategoryName());
            }
          );
          
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}

class FoodDetailCard extends StatelessWidget {
  const FoodDetailCard({
    super.key,
    required this.food,
  });

  final FoodNote food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        color: Theme.of(context).primaryColor,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(food.foodName, style: const TextStyle(fontSize: 20),),
              subtitle: Text(food.restName, style: const TextStyle(fontSize: 20),),
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
        )
      )
    );
  }
}