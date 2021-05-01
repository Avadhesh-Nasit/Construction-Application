// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:location/location.dart';
//
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:async';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           body: FireMap(),
//         )
//     );
//   }
// }
//
// class FireMap extends StatefulWidget {
//   State createState() => FireMapState();
// }
//
//
// class FireMapState extends State<FireMap> {
//   GoogleMapController mapController;
//   Location location = new Location();
//
//   Firestore firestore = Firestore.instance;
//   Geoflutterfire geo = Geoflutterfire();
//
//   // Stateful Data
//   BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
//   Stream<dynamic> query;
//
//   // Subscription
//   StreamSubscription subscription;
//
//   build(context) {
//     return Stack(children: [
//
//       GoogleMap(
//         initialCameraPosition: CameraPosition(
//             target: LatLng(24.142, -110.321),
//             zoom: 15
//         ),
//         onMapCreated: _onMapCreated,
//         myLocationEnabled: true,
//         mapType: MapType.hybrid,
//         compassEnabled: true,
//         trackCameraPosition: true,
//       ),
//       Positioned(
//           bottom: 50,
//           right: 10,
//           child:
//           FlatButton(
//               child: Icon(Icons.pin_drop, color: Colors.white),
//               color: Colors.green,
//               onPressed: _addGeoPoint
//           )
//       ),
//       Positioned(
//           bottom: 50,
//           left: 10,
//           child: Slider(
//             min: 100.0,
//             max: 500.0,
//             divisions: 4,
//             value: radius.value,
//             label: 'Radius ${radius.value}km',
//             activeColor: Colors.green,
//             inactiveColor: Colors.green.withOpacity(0.2),
//             onChanged: _updateQuery,
//           )
//       )
//     ]);
//   }
//
//   // Map Created Lifecycle Hook
//   _onMapCreated(GoogleMapController controller) {
//     _startQuery();
//     setState(() {
//       mapController = controller;
//     });
//   }
//
//   _addMarker() {
//     final Marker marker = Marker(
//         position: mapController.cameraPosition.target,
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
//     );
//
//     mapController.addMarker(marker);
//   }
//
//   _animateToUser() async {
//     var pos = await location.getLocation();
//     mapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(pos['latitude'], pos['longitude']),
//           zoom: 17.0,
//         )
//     )
//     );
//   }
//
//   // Set GeoLocation Data
//   Future<DocumentReference> _addGeoPoint() async {
//     var pos = await location.getLocation();
//     GeoFirePoint point = geo.point(latitude: pos['latitude'], longitude: pos['longitude']);
//     return firestore.collection('locations').add({
//       'position': point.data,
//       'name': 'Yay I can be queried!'
//     });
//   }
//
//   void _updateMarkers(List<DocumentSnapshot> documentList) {
//     print(documentList);
//     mapController.clearMarkers();
//     documentList.forEach((DocumentSnapshot document) {
//       GeoPoint pos = document.data['position']['geopoint'];
//       double distance = document.data['distance'];
//       var marker = MarkerOptions(
//           position: LatLng(pos.latitude, pos.longitude),
//           icon: BitmapDescriptor.defaultMarker,
//           infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
//       );
//
//
//       mapController.addMarker(marker);
//     });
//   }
//
//   _startQuery() async {
//     // Get users location
//     var pos = await location.getLocation();
//     double lat = pos['latitude'];
//     double lng = pos['longitude'];
//
//
//     // Make a referece to firestore
//     var ref = firestore.collection('locations');
//     GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
//
//     // subscribe to query
//     subscription = radius.switchMap((rad) {
//       return geo.collection(collectionRef: ref).within(
//           center: center,
//           radius: rad,
//           field: 'position',
//           strictMode: true
//       );
//     }).listen(_updateMarkers);
//   }
//
//   _updateQuery(value) {
//     final zoomMap = {
//       100.0: 12.0,
//       200.0: 10.0,
//       300.0: 7.0,
//       400.0: 6.0,
//       500.0: 5.0
//     };
//     final zoom = zoomMap[value];
//     mapController.moveCamera(CameraUpdate.zoomTo(zoom));
//
//     setState(() {
//       radius.add(value);
//     });
//   }
//
//   @override
//   dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
//
//
// }



////////////////////////////////////////////////////////////////////////////////////////

// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class StoreMap extends StatefulWidget {
//   StoreMap({
//     Key key,
//     @required this.documents,
//     @required this.initialPosition,
//   }) : super(key: key);
//
//   final List<DocumentSnapshot> documents;
//   final LatLng initialPosition;
//   static final CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(45.791789, 24.150390),
//     zoom: 16,
//   );
//
//
//   @override
//   _StoreMapState createState() => _StoreMapState();
// }
//
// class _StoreMapState extends State<StoreMap> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//
//   List<Marker> markers = [];
//   Future<List<Marker>> _createMarkersForLotsAndParkings() async{
//     List<Marker> markersList = [];
//     int markerId = 0;
//     for (DocumentSnapshot document in widget.documents){
//       // ignore: deprecated_member_use
//       String documentId = document.documentID;
//       DocumentReference parkingDocReference =
//       // ignore: deprecated_member_use
//       Firestore.instance.collection("markers").document(documentId);
//       DocumentSnapshot parkingDocRef = await parkingDocReference.get();
//       markersList.add(Marker(
//           markerId: MarkerId(markerId.toString()),
//           position: LatLng(parkingDocRef.get('location').latitude,
//               parkingDocRef.get('location').longitude),
//           onTap: () => _changeMap(LatLng(
//               parkingDocRef.get('location').latitude,
//               parkingDocRef.get('location').longitude)),
//           infoWindow: InfoWindow(
//               title: document.get('location'),
//               snippet: document.get('location')),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
//       );
//       markerId++;
//       QuerySnapshot subDocuments = await parkingDocReference.collection("location").get();
//       // ignore: deprecated_member_use
//       // ignore: deprecated_member_use
//       List<DocumentSnapshot> subDocumentsSnapshots = subDocuments.documents;
//       for (DocumentSnapshot subDoc in subDocumentsSnapshots){
//         // ignore: deprecated_member_use
//         String subDocId = subDoc.documentID;
//         DocumentSnapshot snapshot = await parkingDocReference.collection("markers")
//         // ignore: deprecated_member_use
//             .document(subDocId).get();
//         print(snapshot.get('location').latitude);
//
//         markersList.add(
//           Marker(
//               markerId:MarkerId(markerId.toString()),
//               position: LatLng(snapshot.get('location').latitude,
//                   snapshot.get('location').longitude),
//               onTap: () => _changeMap(LatLng(
//                   snapshot.get('location').latitude,
//                   snapshot.get('location').longitude)),
//               infoWindow: InfoWindow(
//                   title: document.get('location'),
//                   snippet: document.get('location')),
//               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)),
//         );
//         markerId++;
//
//       }
//
//     }
//     return Future.value(markersList);
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _createMarkersForLotsAndParkings().then((List<Marker> lotsMarkers){
//       setState((){
//         markers = lotsMarkers;
//       });
//
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         zoomGesturesEnabled: true,
//         mapType: MapType.hybrid,
//         initialCameraPosition: StoreMap._initialPosition,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         myLocationEnabled: true,
//         markers: markers.toSet(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _currentLocation,
//         child: Icon(Icons.location_searching),
//         backgroundColor: Colors.deepPurple[400],
//       ),
//     );
//   }
//
//   void _currentLocation() async {
//     final GoogleMapController controller = await _controller.future;
//     LocationData currentLocation;
//     var location = new Location();
//     try {
//       currentLocation = await location.getLocation();
//     } on Exception {
//       currentLocation = null;
//     }
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         bearing: 0,
//         target: LatLng(currentLocation.latitude, currentLocation.longitude),
//         zoom: 18.0,
//       ),
//     ));
//   }
//
//   _changeMap(LatLng position) async {
//     final GoogleMapController controller = await _controller.future;
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         bearing: 0,
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 19.4,
//       ),
//     ));
//   }
// }


///////////////////////////////////////////////////////////////////////////////////////////////////////


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool mapToggle = false;
  bool clientsToggle = false;
  bool resetToggle = false;

  var currentLocation;

  var clients = [];

  var currentClient;
  var currentBearing;

  GoogleMapController mapController;

  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
        populateClients();
      });
    });
  }

  populateClients() {
    clients = [];
    Firestore.instance.collection('markers').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientsToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          clients.add(docs.documents[i].data);
          initMarker(docs.documents[i].data,docs.docs[i].id);
        }
      }
    });
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  initMarker(client,request) {
    // mapController.clearMarkers().then((val) {
    //   mapController.addMarker(MarkerOptions(
    //       position:
    //       LatLng(client['location'].latitude, client['location'].longitude),
    //       draggable: false,
    //       infoWindowText: InfoWindowText(client['clientName'], 'Nice')));
    // });
    var markerIdval = request;
    final MarkerId markerId= MarkerId(markerIdval);
    final Marker marker = Marker(markerId: markerId,
      position: LatLng(client['location'].latitude,client['location'].longitude),
      infoWindow: InfoWindow(title: "Fetched Marker",snippet: request['place']),
    );
    setState(() {
      markers[markerId]=marker;
      print(markerId);
    });
  }

  // Widget clientCard(client) {
  //   return Padding(
  //       padding: EdgeInsets.only(left: 2.0, top: 10.0),
  //       child: InkWell(
  //           onTap: () {
  //             setState(() {
  //               currentClient = client;
  //               currentBearing = 90.0;
  //             });
  //             zoomInMarker(client);
  //           },
  //           child: Material(
  //             elevation: 4.0,
  //             borderRadius: BorderRadius.circular(5.0),
  //             child: Container(
  //                 height: 100.0,
  //                 width: 125.0,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(5.0),
  //                     color: Colors.white),
  //                 child: Center(child: Text(client['place']))),
  //           )));
  // }

  zoomInMarker(client) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            client['location'].latitude, client['location'].longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });
  }

  resetCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 10.0))).then((val) {
      setState(() {
        resetToggle = false;
      });
    });
  }

  addBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 360.0) {}
        else {
          currentBearing = currentBearing + 90.0;
        }
      });
    });
  }

  removeBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 0.0) {}
        else {
          currentBearing = currentBearing - 90.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map Demo'),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height - 80.0,
                    width: double.infinity,
                    child: mapToggle
                        ? GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition:CameraPosition(
                        target: LatLng(40.7128, -74.0060),
                        zoom: 10.0
                      ),
                      // options: GoogleMapOptions(
                      //     cameraPosition: CameraPosition(
                      //         target: LatLng(40.7128, -74.0060),
                      //         zoom: 10.0)),
                    )
                        : Center(
                        child: Text(
                          'Loading.. Please wait..',
                          style: TextStyle(fontSize: 20.0),
                        ))),
                // Positioned(
                //     top: MediaQuery.of(context).size.height - 250.0,
                //     left: 10.0,
                //     child: Container(
                //         height: 125.0,
                //         width: MediaQuery.of(context).size.width,
                //         child: clientsToggle
                //             ? ListView(
                //           scrollDirection: Axis.horizontal,
                //           padding: EdgeInsets.all(8.0),
                //           children: clients.map((element) {
                //             return clientCard(element);
                //           }).toList(),
                //         )
                //             : Container(height: 1.0, width: 1.0))),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 15.0,
                    child: FloatingActionButton(
                      onPressed: resetCamera,
                      mini: true,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.refresh),
                    ))
                    : Container(),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 60.0,
                    child: FloatingActionButton(
                        onPressed: addBearing,
                        mini: true,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.rotate_left
                        ))
                )
                    : Container(),
                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            50.0),
                    right: 110.0,
                    child: FloatingActionButton(
                        onPressed: removeBearing,
                        mini: true,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.rotate_right)
                    ))
                    : Container()
              ],
            )
          ],
        ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}

