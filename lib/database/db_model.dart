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

  Future<void> getWeightsFromCloud() async {
    if (!globals.isLoggedIn) return;

    CollectionReference cloudWeight = Firestore.instance.collection('Weight');
    Query query = cloudWeight.where('user', isEqualTo: globals.userEmail);
    QuerySnapshot collectionSnapshot = await query.getDocuments();
    List<DocumentSnapshot> cloudWeightsList = collectionSnapshot.documents.toList();
    for (DocumentSnapshot document in cloudWeightsList) {
      Weight weight = Weight.fromMap(document.data);
      await localInsertWeight(weight);
    }
  }

  Future<int> localInsertWeight(Weight newWeight) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Weight',
      newWeight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertWeight(Weight weight) async {
    int newWeightID = await localInsertWeight(weight);
    weight.weightID = newWeightID;
    if (globals.isLoggedIn) {
      CollectionReference cloudWorkout = Firestore.instance.collection('Weight');
      await cloudWorkout.document('Weight$newWeightID${globals.userEmail}').setData(weight.toMap());
    }
    return newWeightID;
  }

  Future<int> deleteWeight(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'Weight',
      where: 'weightID = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String,dynamic>>> getFoods() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query(
      'Food',
      where: 'user = ? ORDER BY date(datetime)',
      whereArgs: [globals.userEmail],
    );
    return maps;
  }

  Future<void> getFoodsFromCloud() async {
    CollectionReference cloudWeight = Firestore.instance.collection('Food');
    Query query = cloudWeight.where('user', isEqualTo: globals.userEmail);
    QuerySnapshot collectionSnapshot = await query.getDocuments();
    List<DocumentSnapshot> cloudFoodList = collectionSnapshot.documents.toList();
    for (DocumentSnapshot document in cloudFoodList) {
      Food food = Food.fromMap(document.data);
      await localInsertFood(food);
    }
  }

  Future<int> localInsertFood(Food newFood) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Food',
      newFood.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertFood(Food food) async {
    int newFoodID = await localInsertFood(food);
    food.calorieID = newFoodID;
    if (globals.isLoggedIn) {
      CollectionReference cloudFood = Firestore.instance.collection('Food');
      await cloudFood.document('Food$newFoodID${globals.userEmail}').setData(food.toMap());
    }
    return newFoodID;
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

  // This method helps sync data between devices
  Future<void> getDataFromCloud() async {
    if (!globals.isLoggedIn) return;

    await getWeightsFromCloud();
    await getFoodsFromCloud();
    await getWorkoutsFromCloud();
  }
}