class Weight {
  int weightID;
  DateTime datetime;
  double weight;

  Weight({this.weightID, this.datetime, this.weight});

  Map<String,dynamic> toMap() {
    return {
      'weightID': this.weightID,
      'datetime': this.datetime.toString(),
      'weight': this.weight,
    };
  }

  // Weight.fromMap(Map<String,dynamic> map) {
  //   this.weightID = map['weightID'];
  //   this.datetime = map['datetime'];
  //   this.weight = map['weight'];
  // }
}