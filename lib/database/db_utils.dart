import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    return openDatabase(
      path.join(await getDatabasesPath(), 'fitness.db'),
      onCreate: (db, version) {
        if (version > 1) {
          // downgrade path
        }
        db.execute('CREATE TABLE weight (weight_id INTEGER PRIMARY KEY, date DATE NOT NULL, weight REAL NOT NULL);');
        db.execute('CREATE TABLE calorie_intake (calorie_id INTEGER PRIMARY KEY, date DATE NOT NULL, meal_type TEXT NOT NULL, food TEXT, calorie_intake REAL NOT NULL);');
        db.execute('CREATE TABLE calorie_intake (workout_id INTEGER PRIMARY KEY, date DATE NOT NULL, day TEXT, workout TEXT NOT NULL, reps INTEGER, sets INTEGER, duration INTEGER, is_completed INTEGER NOT NULL, calories_burned REAL);');
      },
      version: 1,
    );
  }
}