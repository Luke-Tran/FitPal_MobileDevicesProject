import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_devices_project/custom-widgets/gauge_graph.dart';
import 'package:mobile_devices_project/database/db_model.dart';
import 'package:mobile_devices_project/custom-widgets/track_calories_btn.dart';
import 'package:mobile_devices_project/database/weight.dart';
import 'package:mobile_devices_project/globals.dart' as globals;
import 'package:charts_flutter/flutter.dart' as charts;

class Checkin extends StatefulWidget {

  Checkin({Key key}) : super(key: key);

  @override
  _CheckinState createState() => _CheckinState();

}

class _CheckinState extends State<Checkin> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckInWeight(),
    );
  }
}

//class for entering check-in weight
class CheckInWeight extends StatefulWidget {
	CheckInWeight({Key key}) : super(key: key);

	@override
	_CheckInWeightState createState() => _CheckInWeightState();
}

class _CheckInWeightState extends State<CheckInWeight> {
  final _formKey = GlobalKey<FormState>();
  final _model = DBModel();
	var _weight;
	String _progress;
	DateTime now = new DateTime.now();
	DateTime _currentDate;
  var _lastInsertedId = -1;
  int _dailyCalsIntake = 0;
  int _weeklyCalsIntake = 0;
  double _dailyWeight = 0;
  double _weeklyWeight = 0;
  double _enteredWeight = 0;

  Future<void> _insertWeight(double value) async {
    Weight newWeight = Weight(datetime: DateTime.now(), weight: value, user: globals.userEmail);
    _lastInsertedId = await _model.insertWeight(newWeight);
  }

  Future<void> _deleteWeight(int id) async {
    _model.deleteWeight(id);
  }

  Future<void> _listAllWeights() async {
    List<Map<String, dynamic>> weightList = await _model.getWeights();
    print('Weights:');
    for (Map<String, dynamic> weight in weightList) {
      print(weight);
    }
  }

	@override
	Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                _cardLoader(_getWeightCard()),
                _cardLoader(_getCalsCard()),
              ],
            ),
            Row(
              children: <Widget>[
                _cardLoader(_weightGraphCard()),
                _cardLoader(_calsGraphCard()),
              ],
            ),
            SizedBox(height: 30),
            _signInPrompt(),
          ],
        ),
      ),
    );
	}

  Widget _cardLoader(Future<Widget> card) {

    return FutureBuilder(
      future: card,
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();
        if(snapshot.data == null) return Card(child: Text("Error"));
        return snapshot.data;
      },
    );

  }

  Widget _graphLoader(Widget graph, Future<Widget> future) {

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();
        return graph;
      },
    );

  }

  Future<void> _getWeight() async {

    double total = 0;
    int amtCounted = 0;

    _dailyWeight = await _model.getWeightToday();
    if(_dailyWeight == null) _dailyWeight = 0;

    List<Weight> l;

    l = await _model.getWeightDays(7);
    for(int i = 0;i < l.length;i++) {
      total += l[i].weight;
      amtCounted++;
    }

    if(amtCounted != 0) _weeklyWeight = total/amtCounted;
    else _weeklyWeight = 0;

  }

  Future<Widget> _getWeightCard() async {

    double total = 0;
    int amtCounted = 0;

    _dailyWeight = await _model.getWeightToday();
    if(_dailyWeight == null) _dailyWeight = 0;

    List<Weight> l;

    l = await _model.getWeightDays(7);
    for(int i = 0;i < l.length;i++) {
      total += l[i].weight;
      amtCounted++;
    }

    if(amtCounted != 0) _weeklyWeight = total/amtCounted;
    else _weeklyWeight = 0;

    String errorMsg;
    if(globals.isLoggedIn)
      errorMsg = "Tap to enter";
    else errorMsg = "Log in to view";

    return Expanded(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Enter your weight: "),
                    Container(
                      width: 40,
                      child: TextField(
                        maxLength: 5,
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                        ],
                        onChanged: (str) {
                          _enteredWeight = double.parse(str);
                        },
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      _insertWeight(_enteredWeight);
                      Navigator.of(dialogContext).pop();
                      SnackBar snackBar = SnackBar (
                        content: Text('Weight Saved'),
                        action: SnackBarAction (
                          label: 'Undo',
                          onPressed: () {
                            _deleteWeight(_lastInsertedId);
                            print('Weight deleted');
                          },
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: Text("Add Weight"),
                  )
                ],
              );
            }
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Weight",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _dailyWeight == 0 ? errorMsg : _dailyWeight.toString() + " lb",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "7 day avg",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _weeklyWeight == 0 ? errorMsg : _weeklyWeight.toStringAsFixed(1) + " lb",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateCals() async {

    int daysCounted = 0;

    List<Map<String,dynamic>> foods = await _model.getFoodsToday();
    double intake = 0;
    for (Map<String, dynamic> food in foods) {
      intake += food['calorieIntake'];
    }
    _dailyCalsIntake = intake.toInt();
    globals.isFoodLoaded = true;

    if(_dailyCalsIntake > 0) daysCounted++;

    for(int i = 1;i < 7;i++) {
      foods = await _model.getFoodsDaysAgo(i);
      if(foods != null && foods.length > 0) daysCounted++;
      for (Map<String, dynamic> food in foods) {
        intake += food['calorieIntake'];
      }
    }

    if(daysCounted != 0) _weeklyCalsIntake = intake ~/ daysCounted;

  }

  Future<Widget> _getCalsCard() async {

    await _updateCals();

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          globals.isFoodLoaded = false;
          await Navigator.pushNamed(context, '/foodform');
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Calories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _dailyCalsIntake == 0 ? "Tap to enter" : _dailyCalsIntake.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "7 day avg",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _weeklyCalsIntake.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> _weightGraphCard() async {

    await _getWeight();

    String errorMsg;
    if(globals.isLoggedIn)
      errorMsg = "Tap above to enter";
    else errorMsg = "Log in to view";

    if(_dailyWeight == null || _dailyWeight == 0 || _weeklyWeight == null || _weeklyWeight == 0) {
      return Expanded(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Weight info missing!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  errorMsg,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    double weightDiff = _dailyWeight - _weeklyWeight;
    int percent = min(max((50 + weightDiff).toInt(), 2), 98);

    charts.Color chartCol = charts.Color.fromHex(code: "#458fd9");

    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: GaugeGraph(percent, "cals", chartCol, auxColor: chartCol),
                alignment: Alignment.center,
              ),
              Text(
                weightDiff.toStringAsFixed(1) + " lb difference",
              ),
            ],
          ),
        ),
      ),
    );

  }

  Future<Widget> _calsGraphCard() async {

    await _updateCals();

    if(_dailyCalsIntake == null || _dailyCalsIntake == 0 || _weeklyCalsIntake == null || _weeklyCalsIntake == 0) {
      return Expanded(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Calories data missing!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Cannot display graphs",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    //Red above average, green normally, bluish-green below

    int percent = 100 - min(((_weeklyCalsIntake - _dailyCalsIntake)/_weeklyCalsIntake * 100).toInt(), 100);
    int r = 0, g = 0, b = 0;

    if(_weeklyCalsIntake != 0) {
      r = min(max(_dailyCalsIntake - _weeklyCalsIntake, 0), 255);
      
      if(_dailyCalsIntake < _weeklyCalsIntake) 
        g = 255;
      else g = max(0, 255 - (_dailyCalsIntake - _weeklyCalsIntake));

      b = min((max(_weeklyCalsIntake - _dailyCalsIntake, 0) / _weeklyCalsIntake * 340).toInt(), 255);
    }

    charts.Color chartCol = charts.ColorUtil.fromDartColor(Color.fromRGBO(r, g, b, 1));

    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: GaugeGraph(percent, "cals", chartCol),
                alignment: Alignment.center,
              ),
              Text(
                _dailyCalsIntake.toString() + "/" + _weeklyCalsIntake.toString() + " cals today",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInPrompt() {

    if(globals.isLoggedIn) return Container();
    return Text(
      "For full functionality, please sign in using the settings button above.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );

  }

}
