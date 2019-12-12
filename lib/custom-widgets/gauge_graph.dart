import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GaugeGraph extends StatelessWidget {

  int percent = 0;
  bool animate = false;
  String label;
  charts.Color color, auxColor;

  GaugeGraph(this.percent, this.label, this.color, {this.auxColor});

  Widget build(BuildContext context) {
    return charts.PieChart(
      createData(),
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 10,
        startAngle: 4/5 * pi,
        arcLength: 7/5 * pi,
      ),
    );
  }

  List<charts.Series<GaugeSegment, String>> createData() {

    if(auxColor == null) auxColor = charts.Color.fromHex(code: "#dbdad5");

    List<GaugeSegment> data = [
      GaugeSegment(label, percent, color),
      GaugeSegment("", 100-percent, auxColor),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: "Segments",
        domainFn: (segment, _) => segment.segment,
        measureFn: (segment, _) => segment.size,
        colorFn: (segment, _) => segment.color,
        data: data,
      ),
    ];
  }

}

class GaugeSegment {
  String segment;
  int size;
  charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}