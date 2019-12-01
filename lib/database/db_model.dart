import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db_utils.dart';
import 'weight.dart';
import 'workout.dart';
import '../globals.dart' as globals;

class DBModel {
  Future<List<Map<String,dynamic>>> getAllWeights() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('Weight');
    return maps;
  }

  Future<int> insertWeight(Weight newWeight) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Weight',
      newWeight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteWeight(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'Weight',
      where: 'weightID = ?',
      whereArgs: [id],
    );
  }

  Future<List<Workout>> getAllWorkouts() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query(
      'Workout',
      where: 'user = ? AND isCompleted = ?',
      whereArgs: ['${globals.userEmail}', 0],
    );
    List<Workout> workouts = [];
    for (int i = 0; i < maps.length; i++) {
      workouts.add(Workout.fromMap(maps[i]));
    }
    return workouts;
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await DBUtils.init();
    int newWorkoutID = await db.insert(
      'Workout',
      workout.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    workout.workoutID = newWorkoutID;
    if (globals.isLoggedIn) {
      CollectionReference cloudWorkout = Firestore.instance.collection('Workout');
      //await cloudWorkout.add(workout.toMap());
      await cloudWorkout.document('Workout$newWorkoutID${globals.userEmail}').setData(workout.toMap());
    }
    return newWorkoutID;
  }

  Future<int> deleteWorkout(int id) async {
    final db = await DBUtils.init();
    if (globals.isLoggedIn) {
      CollectionReference cloudWorkout = Firestore.instance.collection('Workout');
      cloudWorkout.document('Workout$id${globals.userEmail}').delete();
    }
    return await db.delete(
      'Workout',
      where: 'workoutID = ?',
      whereArgs: [id],
    );
  }
}