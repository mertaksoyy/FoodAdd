/*
}*/

import 'package:flutter/material.dart';

import 'package:foodadd/model/food_note/food_note_dao.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';

import 'package:foodadd/view/food_detail_card.dart';

import 'package:foodadd/view/food_add_popup.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.searchKey});

  final String searchKey;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  Future<List<FoodNote>> searchFoodNote(String searchKey) async {
    List<FoodNote> searchRes = await FoodsDao().getSearchRes(searchKey);

    return searchRes;
  }

  Future openAddDialog(FoodNote? food) async{
    await showDialog(
      context: context, 
      builder: (context) {
        return FoodAddDialog(category: food!.category, food: food,);
      }
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FoodNote>>(
        future: searchFoodNote(widget.searchKey,),

        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<FoodNote>? searchRes = snapshot.data;

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
                    iconSize: 30,
                    icon: const Icon(
                      Icons.arrow_back_ios_new, 
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ), 

                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Search Results", 
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
                    childCount: searchRes!.length,

                    (context, index) {
                      FoodNote food = searchRes[index];
                      return GestureDetector(
                        child: FoodDetailCard(food: food,),
                        onTap: () => openAddDialog(food),
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
    );
  }
}