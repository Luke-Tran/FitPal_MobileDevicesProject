import 'package:flutter/material.dart';
import 'database/db_model.dart';

class FoodForm extends StatefulWidget {
  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track calories'),),
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
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Number of calories',
                ),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration (
                  labelText: 'Meal type',
                ),
                items: <String> ['1-Week', '1-Month', '6-Months', '1-Year']
                  .map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String> (
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
              ),
            ]
          ),
        ),
      ),
    );
  }
}