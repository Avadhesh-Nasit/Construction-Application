import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  final CollectionReference profileList =
  FirebaseFirestore.instance
      .collection('propertyDetails');


  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class UserpostManager{
  final CollectionReference postList = FirebaseFirestore.instance.collection('Users').document(FirebaseAuth.instance.currentUser.uid).collection('usersPost');
  Future getUserPostList() async{
    List itemList = [];
    try{
      await postList.getDocuments().then((querySnapshot){
        querySnapshot.documents.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}

class FavoritePostManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  final CollectionReference favoritepostList =
  FirebaseFirestore.instance
      .collection('Users').document(FirebaseAuth.instance.currentUser.uid).collection('favoriteList');


  Future getFavoritePostList() async {
    List itemsList = [];

    try {
      await favoritepostList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}




class DatabaseManager1 {

  Future getUsersList(String state,String city,String sellOrRent,String propertyType,String status) async {
    List itemsList = [];
    final profileList =
    FirebaseFirestore.instance
        .collection('propertyDetails').where('state',isEqualTo: state)
                                      .where('city',isEqualTo:city)
                                      .where('sellOrRent',isEqualTo: sellOrRent)
                                      .where('propertyType',isEqualTo: propertyType)
                                      .where('status',isEqualTo: status)
                                      ;

    try {
      await profileList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}