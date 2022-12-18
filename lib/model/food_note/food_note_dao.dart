import 'package:foodadd/model/food_note/food_note_database_helper.dart';
import 'package:foodadd/model/food_note/food_note_model.dart';

class FoodsDao {

  Future<List<FoodNote>> getAllNotes() async {
    
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> foods = await db.rawQuery("SELECT * FROM Foods");

    return List.generate(foods.length, (i) {
      var food = foods[i];

      return FoodNote(food["id"], food["category"], food["foodName"], food["restName"], food["rating"]);
    });
  }


  Future<void> addFoodNote(String category, String foodName, String restName, double rating) async {

    var db = await DatabaseHelper.databaseAccess();

    Map<String, dynamic> note = {};
    note["category"] = category;
    note["foodName"] = foodName;
    note["restName"] = restName;
    note["rating"] = rating;

    await db.insert("Foods", note);
  }


  Future<List<FoodNote>> getCategory(String category) async {

    var db = await DatabaseHelper.databaseAccess();

    //List<Map<String, dynamic>> foods = await db.rawQuery("SELECT * FROM Foods WHERE category = $category");
    List<Map<String, dynamic>> foods = await db.query("Foods", where: "category = ?", whereArgs: [category]);

    return List.generate(foods.length, (i) {
      var food = foods[i];

        return FoodNote(food["id"], food["category"], food["foodName"], food["restName"], food["rating"]);
      }
    );
  }

  Future<void> foodUpdate(int foodID, String category, String foodName, String restName, double rating) async{
    var db = await DatabaseHelper.databaseAccess();

    Map<String, dynamic> info = {};
    info["category"] = category;
    info["foodName"] = foodName;
    info["restName"] = restName;
    info["rating"] = rating;

    await db.update("Foods", info, where: "id = ?", whereArgs: [foodID]);
  }

  Future<void> foodDelete(int foodID) async{
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("Foods", where: "id = ?", whereArgs: [foodID]);
  }


  Future<void> deleteDB() async {
    var db = await DatabaseHelper.databaseAccess();

    db.delete("Foods");
  }
}