import 'package:flutter/material.dart';

class Exercises {
	String exercise_name; // uses the name of the workout from the database 
	var rep_set; // uses the value rep from the database after the exercise is added to workout
	var set_set; // uses the value set from the database after the exercuse is added to wotkour
	
	Exercises.exercise (String exercise_name, var rep_set, var set_set)
	{
		this.exercise_name = exercise_name;
		this.rep_set = rep_set;
		this.set_set = set_set;
	}

	build() {
		return 
			Container (
				child: ListTile(
					leading: Column (
						children:<Widget> [
							// container for the rep_set value
							Container (
								padding: EdgeInsets.all(8.0),
								child: Text('${rep_set}')
							),
							// container for the rep_set label
							Container( 
								child: Text('Reps')
							),
						]
					),
					// container for the title that containds the exercise name 
					title: Container(
						padding: EdgeInsets.all(0.0), 
						alignment: Alignment.center,
						child:Text('${exercise_name}'),
					),
					trailing: Column (
						children:<Widget> [
							// container for the set_set value
							Container(
								padding: EdgeInsets.all(8.0),
								child: Text('${set_set}')
							),
							// container for the set_sets label
							Container(
								child: Text('Sets')
							),
						]
					),
				)
			);
	}

}
