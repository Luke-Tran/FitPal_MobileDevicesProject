import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db_utils.dart';
import 'weight.dart';
import 'workout.dart';
import 'food.dart';
import '../globals.dart' as globals;

class DBModel {
  Future<List<Map<String,dynamic>>> getWeights() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query(
      'Weight',
      where: 'user = ? ORDER BY date(datetime)',
      whereArgs: [globals.userEmail],
    );
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

  Future<List<Workout>> getWorkouts() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query(
      'Workout',
      where: 'user = ? AND isCompleted = ? ORDER BY date(datetime)',
      whereArgs: [globals.userEmail, 0],
    );
    List<Workout> workouts = [];
    for (int i = 0; i < maps.length; i++) {
      workouts.add(Workout.fromMap(maps[i]));
    }
    return workouts;
  }

  // This method helps sync data between devices
  Future<void> getWorkoutsFromCloud() async {
    if (!globals.isLoggedIn) return;

    CollectionReference cloudWorkout = Firestore.instance.collection('Workout');
    Query query = cloudWorkout.where('user', isEqualTo: globals.userEmail);
    QuerySnapshot collectionSnapshot = await query.getDocuments();
    List<DocumentSnapshot> cloudWorkoutsList = collectionSnapshot.documents.toList();
    for (DocumentSnapshot document in cloudWorkoutsList) {
      Workout workout = Workout.fromMap(document.data);
      await localInsertWorkout(workout);
    }
  }

  Future<int> localInsertWorkout(Workout workout) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Workout',
      workout.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertWorkout(Workout workout) async {
    int newWorkoutID = await localInsertWorkout(workout);
    workout.workoutID = newWorkoutID;
    if (globals.isLoggedIn) {
      CollectionReference cloudWorkout = Firestore.instance.collection('Workout');
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

  Future<int> insertFood(Food newFood) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Food',
      newFood.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}