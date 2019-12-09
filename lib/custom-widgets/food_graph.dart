import 'package:flutter/material.dart';

class FoodGraph extends StatelessWidget {

  Widget build(BuildContext context) {

    return FutureBuilder(
      future:getCalories(),
      builder: (context) {
        
      })
  }
}