
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'database/weight.dart';

class WeightDisplay extends StatelessWidget {

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( //Migrate to unified appbar
        title: Text("FitPal"),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder(
        future: _getWeights(),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done)
            return Container();
          else {
            List<DataRow> cellRows = [];
            for(int i = 0;i < snapshot.data.length;i++) {
              cellRows.add(DataRow(
                cells: <DataCell>[
                  DataCell(Text(snapshot.data[i].datetime.toString())),
                  DataCell(Text(snapshot.data[i].weight.toString())),
                ]
              ));
            }

            return DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text("Time"), numeric: false),
                DataColumn(label: Text("Weight"), numeric: true),
              ],
              rows: cellRows,
            );
          }
        },
      ),
    );
  }


  //move to db_model
  Future<List<Weight>> _getWeights() async {
    Query q = Firestore.instance.collection('Weight');
    QuerySnapshot snapshot = await q.getDocuments();
    List<DocumentSnapshot> docs = snapshot.documents;

    List<Weight> l = [];

    for(int i = 0;i < docs.length;i++) {
      if(docs[i].data['datetime'] != null) l.add(Weight.fromMap(docs[i].data));
    }

    l.sort((a, b) => a.datetime.compareTo(b.datetime));
    return l;

  }

}