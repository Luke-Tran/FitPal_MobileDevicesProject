import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mobile_devices_project/database/db_model.dart';
import 'package:mobile_devices_project/database/weight.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_devices_project/globals.dart' as globals;

class WeightChart extends StatelessWidget {

  // final _model = DBModel();

  Widget build(BuildContext context) {

    List<Weight> weightList = [Weight(datetime: DateTime.now(), weight: 125), Weight(datetime: DateTime.parse('2019-12-01 14:41:03.584474'), weight: 128)];
    
    return FutureBuilder(
      future: getWeights(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done)
          return Container();
        List<charts.Series<Weight, DateTime>> series = [
          new charts.Series<Weight, DateTime>(
            id: 'Weights',
            colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
            domainFn: (Weight weight, _) => weight.datetime,
            measureFn: (Weight weight, _) => weight.weight,
            data: snapshot.data,
          )..setAttribute(charts.rendererIdKey, 'customPointRenderer'),
        ];

        //Switch from fixed size
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          child: charts.TimeSeriesChart(
            series,
            defaultRenderer: new charts.LineRendererConfig(),
            customSeriesRenderers: [
              new charts.LineRendererConfig(
                customRendererId: 'customPointRenderer',
                includePoints: true,
                radiusPx: 2,
              ),
            ],
            behaviors: [
              new charts.ChartTitle('Weight Loss Progress',
              behaviorPosition: charts.BehaviorPosition.top,
              titleStyleSpec: charts.TextStyleSpec(fontSize: 30),
              ),
              new charts.ChartTitle('Date',
              behaviorPosition: charts.BehaviorPosition.bottom,
              ),
              new charts.ChartTitle('Weight (lbs)',
              behaviorPosition: charts.BehaviorPosition.start,
              ),
            ],
            primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.GridlineRendererSpec(),
              showAxisLine: true,
            ),
            domainAxis: new charts.DateTimeAxisSpec(
                tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                  day: new charts.TimeFormatterSpec(
                    format: 'dd',
                    transitionFormat: 'dd MMM',
                  ),
              ),
              renderSpec: new charts.GridlineRendererSpec(),
              showAxisLine: true,
            ),
          ),
        );
      }
    );
  }

  //Move to db_model
  Future<List<Weight>> getWeights() async {
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

