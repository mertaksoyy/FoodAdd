import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static const String databaseName = "food.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = p.join(await getDatabasesPath(), databaseName);

    Database database = await openDatabase(
      databasePath, version: 1,
      onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE Foods (id INTEGER PRIMARY KEY, category TEXT, foodName TEXT, restName TEXT, rating FLOAT)');
      });

    return database;
  }
}