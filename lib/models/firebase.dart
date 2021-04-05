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