import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';

Future<void> userSetup(String displayName, String email, String phoneNumber,String role,String Image) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  var firebaseUser= await FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.doc(firebaseUser.uid).set({'name': displayName, 'userId': uid, 'email': email, 'mobileNumber':phoneNumber,'role':role ,'Image':Image});
  //users.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number':phoneNumber, 'Password': password,'Role':role });
  return;
}
//
// Stream<QuerySnapshot> get users{
//   return userCollection.snapshots();
// }
//
// final userCollection = FirebaseFirestore.instance.collection("Users");
// String uid = FirebaseAuth.instance.currentUser.uid.toString();
// Future getCurrentUserData() async{
//   try {
//     DocumentSnapshot ds = await userCollection.doc(uid).get();
//     String name =ds.get('Name');
//     String email=ds.get('Email');
//     return [name,email];
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }

Future<void> user(String displayName,String phoneNumber, String password,String role) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  var firebaseUser= await FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.doc(firebaseUser.uid).set({'name': displayName, 'userId': uid,'mobileNumber':phoneNumber, 'password': password,'role':role });
  //users.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number':phoneNumber, 'Password': password,'Role':role });
  return;
}

Future<void> postProperty(String category,
                          String postBy,
                          String sr_radio,
                          String pro_type,
                          String projectName,
                          String address,
                          String landmark,
                          String city,
                          String state,
                          String pro_detail,
                          String area,
                          String price,
                          String description,
                          String con_status,
                          String firstImage,
                          String secondImage,
                          String thirdImage,
                          String userId,
                          String location
                          ) async {

  final query = location;
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  DocumentReference property = FirebaseFirestore.instance.collection('propertyDetails').doc();
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  property.set({
    'category': category,
    'postedBy': postBy,
    'sellOrRent': sr_radio,
    'propertyType': pro_type,
    'projectName': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'detail': pro_detail,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'postedById':userId,
    'propertyId':property.documentID,
    'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude)
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}

Future<void> postCommProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String area, String price, String description, String con_status,String firstImage,String secondImage,String thirdImage,String detail,String userId,String location) async {
  DocumentReference property = FirebaseFirestore.instance.collection('propertyDetails').doc();
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  final query = location;
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  property.set({
    'category': category,
    'postedBy': postBy,
    'sellOrRent': sr_radio,
    'propertyType': pro_type,
    'projectName': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'detail':detail,
    'postedById': userId,
    'propertyId':property.documentID,
    'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude)
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}



Future<void> FavoriteProperty(String category, String postBy, String projectName, String city, String price, String con_status, String first_image) async {
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  CollectionReference users2 = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference property = FirebaseFirestore.instance.collection(
      'favoriteList');
  users2.document(firebaseUser.uid).collection('favoriteList').document().set({
    'category': category,
    'postedBy': postBy,
    'projectName': projectName,
    'city': city,
    'price': price,
    'status': con_status,
    'firstImage': first_image
  });
}

Future<void> postNewProjectRes(String category,
    String postBy,
    String sr_radio,
    String pro_type,
    String projectName,
    String address,
    String landmark,
    String city,
    String state,
    String pro_detail,
    String area,
    String price,
    String description,
    String con_status,
    String firstImage,
    String secondImage,
    String thirdImage,
    String userId,
    String location
    ) async {

  final query = location;
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  DocumentReference property = FirebaseFirestore.instance.collection('newProject').doc();
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  property.set({
    'category': category,
    'postedBy': postBy,
    'sellOrRent': sr_radio,
    'propertyType': pro_type,
    'projectName': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'detail': pro_detail,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'postedById':userId,
    'propertyId':property.documentID,
    'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude)
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}

Future<void> postNewProjectCom(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String area, String price, String description, String con_status,String firstImage,String secondImage,String thirdImage,String detail,String userId,String location) async {
  DocumentReference property = FirebaseFirestore.instance.collection('newProject').doc();
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  final query = location;
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  property.set({
    'category': category,
    'postedBy': postBy,
    'sellOrRent': sr_radio,
    'propertyType': pro_type,
    'projectName': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'detail':detail,
    'postedById': userId,
    'propertyId':property.id,
    'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude)
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}
