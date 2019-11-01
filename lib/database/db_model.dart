import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';

class DBModel {
  Future<int> insertWeight(double value) async {
    final db = await DBUtils.init();
    return await db.insert(
      'Weight',
      {
        'datetime': DateTime.now().toString(),
        'weight': value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String,dynamic>>> getAllWeights() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('Weight');
    return maps;
  }
}