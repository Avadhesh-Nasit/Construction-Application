import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/homeScreenBuilderAndBroker.dart';
import 'package:construction_application/screens/home_screen.dart';
import 'package:construction_application/screens/my_homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'myPost.dart';

// void main() => runApp(MyApp());

class MapBuilder extends StatefulWidget {
  final String value;

  const MapBuilder({Key key, this.value}) : super(key: key);
  @override
  _MapBuilderState createState() => _MapBuilderState();
}

class _MapBuilderState extends State<MapBuilder> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        // infoWindow: InfoWindow(
        //   title: 'Really cool place',
        //   snippet: '5 Star Rating',
        // ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      print(_lastMapPosition);
    });
  }
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  void post() async{
    await FirebaseFirestore.instance.collection('propertyDetails').doc(widget.value).set({
      'location': GeoPoint(_lastMapPosition.latitude, _lastMapPosition.longitude),
    },SetOptions(merge: true)).then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add property to map'),
          backgroundColor: Colors.indigo,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("image/locator.png"),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: (){
                        _onAddMarkerButtonPressed();
                        post();
                        print(widget.value);
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => HomeScreen1()));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.indigo,
                      child: Column(
                        children: [
                          const Icon(Icons.add_location, size: 28.0),
                          const Text("Save"),
                        ],
                      ),
                      // Icon(Icons.add_location, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      heroTag: "btn3",
                      onPressed: (){
                        print(widget.value);
                        FirebaseFirestore.instance.collection('propertyDetails').doc(widget.value).update({
                          'location': GeoPoint(0, 0),
                        });
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => HomeScreen1()));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.indigo,
                      child: Column(
                        children: [
                          const Icon(Icons.skip_next, size: 28.0),
                          const Text("Skip"),
                        ],
                      ),
                      // Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
