import 'package:flutter/material.dart';
import 'package:mobile_devices_project/weight_chart.dart';

class Reports extends StatefulWidget {

  Reports({Key key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();

}

class _ReportsState extends State<Reports> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Weight"),
                    Text("100.0lb"),
                  ],
                ),
                WeightChart(),
                // FutureBuilder(
                //   future: r_charts.getWeightChart(),
                //   builder: (context, snapshot) {
                //     if(snapshot.connectionState != ConnectionState.done) {
                //       return Container();
                //     }
                //     return snapshot.data;
                //   }
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}