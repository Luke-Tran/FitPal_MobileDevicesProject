import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';


class Cardio extends StatefulWidget {

  Cardio({Key key}) : super(key: key);

  @override 
  _CardioState createState() => _CardioState();
}

class _CardioState extends State<Cardio> {

var _locationInput;

userPosition() async {
  var currentUserPosition;
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print('User Position: Latitude: ${position.latitude.toString()}, Longitude: ${position.longitude.toString()}');  
  }

getInsertedAddrss() async {
  List<Placemark> insertedAddress = await Geolocator().placemarkFromAddress(_locationInput);
  print('Geocoding: ${insertedAddress[0].position}');
  }

final centre = LatLng(43.9457842,-78.895896);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: Stack(
          children: <Widget> [
            // Display the map 
            FlutterMap(
                options:MapOptions(
                center: centre,
                minZoom: 16.0,
                maxZoom: 50.0, 
                ),
            layers: [
              TileLayerOptions(
                 urlTemplate: "https://api.tiles.mapbox.com/v4/"
                 "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1Ijoic2NoZXJlIiwiYSI6ImNrM2Z5Y2tmdzAwNDgzbmxvNHNibjR5YmoifQ.wzTwzLrrp19Yuqh96yo6gw',
                  'id': 'mapbox.streets',
                },
              ),
              MarkerLayerOptions(
                markers:[
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: centre,
                    builder: (context) => Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.grey,
                        iconSize: 45.0, 
                        onPressed: () {},
                      ),
                    )
                  )
                ]) 
            ]
            ),
            // Input field for GPS
            Container(
              color: Colors.white,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Location',
                ),
                onChanged: (newValue){
                  _locationInput = newValue;
                  print(_locationInput);
                 // userPosition();
                },
              ),
             ),
            Container(
              padding: EdgeInsets.only(top: 75.0),
              child: RaisedButton (
                      onPressed: () {
                        userPosition();
                        getInsertedAddrss();
                        print('Inserted Address: ${_locationInput}');
                      },
                      child: Text('Press for Location')
              )
            ),
          ]
        ),
    );
  }
}

