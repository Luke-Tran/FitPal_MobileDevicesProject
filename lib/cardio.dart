import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Cardio extends StatefulWidget {

  Cardio({Key key}) : super(key: key);

  @override 
  _CardioState createState() => _CardioState();
}

class _CardioState extends State<Cardio> {

  final centre = LatLng(43.9457842,-78.895896); // TODO: Change to user's current location


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          FlutterMap(
            options: MapOptions(
              center: centre, 
              minZoom: 50.0,
            ),
            layers: [
            TileLayerOptions(
              // TODO: grant permissions to download the image map
         // urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
         // subdomains: ['a', 'b', 'c'], 
              urlTemplate:'https://api.mapbox.com/styles/v1/schere/cjzcobx1x2csf1cmppuyzj5ys/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1Ijoic2NoZXJlIiwiYSI6ImNrM2MxdTBwaDBobzczZnBiaXI4ZTNmZGQifQ.jtLis4IAkXOk_Hqv81P8rw',
              additionalOptions: {
              'accessToken': 'sk.eyJ1Ijoic2NoZXJlIiwiYSI6ImNrM2MxdTBwaDBobzczZnBiaXI4ZTNmZGQifQ.jtLis4IAkXOk_Hqv81P8rw',
              'id': 'mapbox.mapbox-streets-v8'
            }
        ),

        MarkerLayerOptions(
          markers: [
            Marker(
              width: 45.0,
              height: 45.0,
              point: centre,
              builder: (context) => Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.blue,
                  iconSize: 45.0,
                  onPressed: () {
                    print('Icon Pressed');
                  },
                  ),
              )
            )
        ])
      ],
       
      ),
        RaisedButton(
          child: Text('Start Running'),
          onPressed: () {
            print('Start Button Pressed');
          } ,)
        ]
      ),
      
        
     );
  }
}