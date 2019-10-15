import 'package:flutter/material.dart';
import 'navigation_app_bar.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
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

	var _weight;
	String _progress;
	DateTime now = new DateTime.now();
	DateTime _currentDate;


	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget> [
				// Text Field for user to put their weight in. 
				TextFormField (
					decoration: const InputDecoration(
						hintText: 'enter your current weight',
						labelText: 'Weight',
						),
					onSaved: (String value) {
						print('Weight is $value');
						// formats and displays the current date
						// TODO: Format the date so it's easier to parse into a graph
						print('Time is ${DateTime(now.day, now.month, now.year)}');
						_weight = value;
						_currentDate = DateTime(now.day, now.month, now.year);
						},
					),
				// Formatting for the 'Check-In' button
				Padding (
					padding: const EdgeInsets.symmetric(vertical: 16.0),
					child: RaisedButton (
						child: Text('Check-In'),
						onPressed: () {
							_formKey.currentState.save();
						}
					)
				),
				// Displays the drop down options for displaying the graph
				DropdownButtonFormField (
					decoration: const InputDecoration (
						labelText: 'Progress',
						),
					value: _progress,
					items: <String> ['1-Week', '1-Month', '6-Months', '1-Year']
						.map<DropdownMenuItem<String>>((String item) {
							return DropdownMenuItem<String> (
								value: item,
								child: Text(item),
							);
						}).toList(),
					onChanged: (String newValue) {
						setState(() {
							_progress = newValue;
							});
						print('Showing progress for $_progress');
						// TODO: display graphs here 
						},
					),
				]
			)
		);
	}
}