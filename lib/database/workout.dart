class Workout {
  int workoutID;
  DateTime datetime;
  int day; //not exactly sure about this? is this the frequency of repeating the workout?
  String workout;
  int reps;
  int sets;
  int duration;
  int isCompleted; //should be maybe bool?
  double caloriesBurned;

  Workout({this.workoutID, this.datetime, this.day, this.workout, this.reps, this.sets, this.duration, this.isCompleted, this.caloriesBurned});

  Map<String,dynamic> toMap() {
    return {
      'workoutID': this.workoutID,
      'datetime': this.datetime.toString(),
      'day': this.day,
      'workout': this.workout.toString(),
      'reps': this.reps,
      'sets': this.sets,
      'duration': this.duration,
      'isCompleted': this.isCompleted,
      'caloriesBurned': this.caloriesBurned,
    };
  }

  Workout.fromMap(Map<String,dynamic> map) {
    this.workoutID = map['workoutID'];
    this.datetime = map['datetime'];
    this.day = map['day'];
    this.workout = map['workout'];
    this.reps = map['reps'];
    this.sets = map['sets'];
    this.duration = map['duration'];
    this.isCompleted = map['isCompleted'];
    this.caloriesBurned = map['caloriesBurned'];
  }

  @override 
  String toString() {
    return 'Todo{workoutID: $workoutID, datetime: $datetime, day: $day, workout: $workout, reps: $reps, sets: $sets, duration: $duration, isCompleted: $isCompleted, caloriesBurned: $caloriesBurned}';
  }
}