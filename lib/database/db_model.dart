import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'weight.dart';
import 'workout.dart';
import '../globals.dart' as globals;

class DBModel {
  Future<int> insertWeight(Weight newWeight) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Weight',
      newWeight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String,dynamic>>> getAllWeights() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('Weight');
    return maps;
  }

  Future<int> deleteWeight(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'Weight',
      where: 'weightID = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Workout',
      workout.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteWorkout(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'Workout',
      where: 'workoutID = ?',
      whereArgs: [id],
    );
  }

  Future<List<Workout>> getAllWorkouts() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query(
      'Workout',
      where: 'user = ?',
      whereArgs: ['${globals.userEmail}'],
    );
    List<Workout> workouts = [];
    for (int i = 0; i < maps.length; i++) {
      workouts.add(Workout.fromMap(maps[i]));
    }
    return workouts;
  }
}