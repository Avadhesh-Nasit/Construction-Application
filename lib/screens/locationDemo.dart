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

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
// class NewMap extends StatefulWidget {
//   @override
//   _NewMapState createState() => _NewMapState();
// }
//
// class _NewMapState extends State<NewMap> {
//   GoogleMapController _controller;
//
//   Position position;
//   bool mapToggle = false;
//   var currentLocation;
//
//   Widget _child;
//
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   BitmapDescriptor pinLocationIcon;
//
//   @override
//   void initState() {
//     _child = SpinKitRipple(
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             color: index.isEven ? Colors.grey : Color(0xffffb838),
//           ),
//         );
//       },
//     );
//     getCurrentLocation();
//     populateClients();
//     setCustomMapPin();
//     super.initState();
//
//
//   }
//
//   void getCurrentLocation() async {
//     Position res = await getCurrentPosition();
//     setState(() {
//       position = res;
//       _child = mapWidget();
//     });
//   }
//
//   populateClients() {
//     FirebaseFirestore.instance.collection('markers').get().then((docs) {
//       if (docs.docs.isNotEmpty) {
//         for (int i = 0; i < docs.docs.length; ++i) {
//           initMarker(docs.docs[i].data(), docs.docs[i].id);
//         }
//       }
//     });
//   }
//
//   void initMarker(tomb, tombId) {
//     var markerIdVal = tombId;
//     final MarkerId markerId = MarkerId(markerIdVal);
//
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(
//           tomb.data()['location'].latitude, tomb.data()['location'].latitude),
//       icon: pinLocationIcon,
//     );
//     setState(() {
//       markers[markerId] = marker;
//     });
//   }
//
//   void setCustomMapPin() async {
//     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5), 'image/icon.png');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Color(0xffffb838)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: _child,
//     );
//   }
//
//   Widget mapWidget() {
//     return Stack(
//       children: <Widget>[
//         GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 10,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               _controller = controller;
//             },
//             compassEnabled: true,
//             myLocationEnabled: true,
//             markers: Set<Marker>.of(markers.values)),
//         SizedBox(
//           height: 26,
//         ),
//       ],
//     );
//   }
//   getCurrentPosition(){
//     Geolocator().getCurrentPosition().then((currloc){
//       setState(() {
//         currentLocation=currloc;
//         mapToggle=true;
//       });
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class NewMap extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  GoogleMapController myController;
  Map<MarkerId,Marker> markers = <MarkerId, Marker>{};
  void initMarker(specify,specifyId) async{
    var markerIdVal= specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker= Marker(
      markerId: markerId,
      position: LatLng(specify['location'].latitude,specify['location'].longitude),
      infoWindow: InfoWindow(title: "Property",snippet: specify['place'])
    );
  setState(() {
    markers[markerId]= marker;
  });
  }
  getMarkerData() async{
    FirebaseFirestore.instance.collection('markers').getDocuments().then((data){
        if(data.documents.isNotEmpty){
          for(int i=0;i<data.documents.length;i++){
              initMarker(data.documents[i].data(), data.documents[i].documentID);
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
