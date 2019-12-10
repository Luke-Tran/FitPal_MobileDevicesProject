import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mobile_devices_project/database/food.dart';
import 'package:intl/intl.dart';

class CalorieChart extends StatelessWidget {

  Widget build(BuildContext context) {
    
    final dateFormatter = DateFormat('MM/dd/yyyy');

    return Scaffold (
      appBar: AppBar (
        title: Text('Food History'),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder(
        future: getCalories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Container();
          else {
            List<DataRow> cellRows = [];
            // data used to fill the chart 
            for (int i = 0; i < snapshot.data.length; i++) {
              cellRows.add(DataRow (
                cells: <DataCell> [
                  DataCell(Text(dateFormatter.format(snapshot.data[i].datetime).toString())),
                  //DataCell(Text(snapshot.data[i].mealType.toString())),
                  DataCell(Text(snapshot.data[i].foodName.toString())),
                  DataCell(Text(snapshot.data[i].calorieIntake.toString())),
                ] 
               )
              );
            }

            return DataTable(
              columns: <DataColumn> [
                DataColumn(label: Text("Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), numeric: false),
                //DataColumn(label: Text('Meal', style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold),), numeric:true),
                DataColumn(label: Text('Item', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), numeric:true),
                DataColumn(label: Text('Calories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),numeric: true),
              ],
              rows: cellRows,
            );
          }
        }
      )
    );
  }

  Future<List<Food>> getCalories() async {
    Query q = Firestore.instance.collection('Food');
    QuerySnapshot snapshot = await q.getDocuments();
    List<DocumentSnapshot> docs = snapshot.documents;

    List<Food> l = [];

    for(int i = 0;i < docs.length;i++) {
      if(docs[i].data['datetime'] != null) l.add(Food.fromMap(docs[i].data));
    }

    l.sort((a, b) => a.datetime.compareTo(b.datetime));
    return l;

}
}