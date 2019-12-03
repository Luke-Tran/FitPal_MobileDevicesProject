import 'package:flutter/material.dart';
import 'database/db_model.dart';
import 'globals.dart' as globals;
import 'database/food.dart';

class FoodForm extends StatefulWidget {
  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();
  int _calorieIntake;
  String _mealType;
  String _foodName;
  final _model = DBModel();
  var _lastInsertedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track calories'),
        backgroundColor: Colors.black54,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              save(context);
              Navigator.of(context).pop();},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Food name',
                ),
                onChanged: (String newValue){
                  setState(() {
                    _foodName = newValue;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Number of calories',
                ),
                onChanged: (String newValue){
                  setState(() {
                    _calorieIntake = int.parse(newValue);
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration (
                  labelText: 'Meal type',
                ),
                items: <String> ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                  .map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String> (
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                onChanged: (String newValue){
                  setState(() {
                    _mealType = newValue;
                  });
                },
              ),
            ]
          ),
        ),
      ),
    );
  }

  Future<void> save(BuildContext context)async{
    Food newFood = 
      Food(foodName: _foodName, 
      calorieIntake: _calorieIntake, 
      mealType: _mealType, 
      user: globals.userEmail,
      datetime: DateTime.now());

    _lastInsertedId = await _model.insertFood(newFood);

    print(_foodName);
    print(_calorieIntake);
    print(_mealType);
    print(globals.userEmail);
  }
}