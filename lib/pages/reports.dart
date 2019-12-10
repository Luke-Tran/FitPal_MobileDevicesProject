import 'package:flutter/material.dart';
import 'package:mobile_devices_project/custom-widgets/weight_chart.dart';
import 'package:mobile_devices_project/custom-widgets/food_graph.dart';

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
              Navigator.pushNamed(context, '/weightdisplay');
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child:Text("Weight Loss Progress", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.only(left: 20),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/weightdisplay');
                            },
                            child:Icon(Icons.arrow_forward,),
                          ),
                        ),
                      ],
                    ),
                    WeightChart(),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/caloriechart');
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child:Text("Calories Consumed", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.only(left: 46),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/caloriechart');
                            },
                            child:Icon(Icons.arrow_forward,),
                          ),
                        ),
                      ],
                    ),
                    FoodGraph(),
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