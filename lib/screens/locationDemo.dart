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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class NewMap extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  GoogleMapController myController;
  Map<MarkerId,Marker> markers = <MarkerId, Marker>{};
  String inputaddr='';

  addToList() async{
    final query = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    FirebaseFirestore.instance.collection('markers').add({
      'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude),
      'place': first.featureName,
    });
  }
  Future addMarker() async{
    await showDialog(
        context: context,
        builder:(BuildContext context){
          return new SimpleDialog(
            title: Text("Add Marker Location",style: TextStyle(fontSize: 17.0),),
            children: <Widget>[
              new TextField(
                onChanged: (String enterLoc){
                  setState(() {
                    inputaddr=enterLoc;
                  });
                },
              ),
              new SimpleDialogOption(
                child: Text("Add It",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                onPressed: (){
                  addToList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  void initMarker(specify,specifyId) async{
    var markerIdVal= specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker= Marker(
      markerId: markerId,
      position: LatLng(specify['location'].latitude,specify['location'].longitude),
      infoWindow: InfoWindow(title: "Property",snippet: specify['projectName'],
          onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail(value: specify['propertyId'],)));
      }
      ),
    );
  setState(() {
    markers[markerId]= marker;
  });
  }
  getMarkerData() async{
    FirebaseFirestore.instance.collection('propertyDetails').getDocuments().then((data){
        if(data.docs.isNotEmpty){
          for(int i=0;i<data.docs.length;i++){
              initMarker(data.docs[i].data(), data.docs[i].id);
          }
        }
    });
  }
 @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Set<Marker> getMarker(){
      return <Marker>[
        Marker(
            markerId: MarkerId("Property Id"),
            position: LatLng(21.1702,72.8311),
            icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "Property")
        )
      ].toSet();
    }
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            addMarker();
          },
        ),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(21.1702,72.8311),
          zoom: 14.0
        ),
        onMapCreated:(GoogleMapController controller){
          myController=controller;
        },
      ),
    );
  }
}
