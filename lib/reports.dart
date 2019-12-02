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
          GestureDetector(
            onTap: () {
              
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Weight",
                          style: DefaultTextStyle.of(context).style.apply(
                            fontSizeFactor: 1.7,
                          ),
                        ),
                        Text(
                          "XXX.Xlb",
                          style: DefaultTextStyle.of(context).style.apply(
                            fontSizeFactor: 1.2,
                          ),
                          ),
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
            ),
          ),
        ],
      ),
    );
  }
}