import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, String email, String phoneNumber, String password,String role) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  var firebaseUser= await FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.document(firebaseUser.uid).set({'name': displayName, 'userId': uid, 'email': email, 'mobileNumber':phoneNumber, 'password': password,'role':role });
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
  users.document(firebaseUser.uid).set({'name': displayName, 'userId': uid,'mobileNumber':phoneNumber, 'password': password,'role':role });
  //users.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number':phoneNumber, 'Password': password,'Role':role });
  return;
}

Future<void> postProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String pro_detail, String area, String price, String description, String con_status,String url) async {
  CollectionReference property = FirebaseFirestore.instance.collection('propertyDetails');
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  property.document().set({
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
    'url' : url
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}

Future<void> postCommProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String area, String price, String description, String con_status,String url) async {
  CollectionReference property = FirebaseFirestore.instance.collection('propertyDetails');
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  property.document().set({
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
    'url': url
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}