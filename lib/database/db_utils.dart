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
        db.execute('CREATE TABLE Weight (weightID INTEGER PRIMARY KEY, datetime TEXT NOT NULL, weight REAL NOT NULL);');
        db.execute('CREATE TABLE CalorieIntake (calorieID INTEGER PRIMARY KEY, datetime TEXT NOT NULL, mealType TEXT NOT NULL, food TEXT, calorieIntake REAL NOT NULL);');
        db.execute('CREATE TABLE Workout (workoutID INTEGER PRIMARY KEY, datetime TEXT NOT NULL, day INTEGER, workout TEXT NOT NULL, reps INTEGER, sets INTEGER, duration INTEGER, isCompleted INTEGER NOT NULL, caloriesBurned REAL);');
      },
      version: 1,
    );
  }
}