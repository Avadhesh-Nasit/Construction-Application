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

class DatabaseManager1 {

  Future getUsersList(String state,String city,String sellOrRent,String propertyType,String status,String postedBy) async {
    List itemsList = [];
    final profileList =
    FirebaseFirestore.instance
        .collection('propertyDetails').where('state',isEqualTo: state)
                                      .where('city',isEqualTo:city)
                                      .where('sellOrRent',isEqualTo: sellOrRent)
                                      .where('propertyType',isEqualTo: propertyType)
                                      .where('status',isEqualTo: status)
                                      .where('postedBy',isEqualTo: postedBy)
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

class FavoritePostManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  // final favoritepostList =
  // FirebaseFirestore.instance
  //     .collection('Property Details');
  final Query query = FirebaseFirestore.instance
      .collection('propertyDetails')
      .where('favorites', arrayContains: FirebaseAuth.instance.currentUser.uid);

  Future getFavoritePostList() async {
    List itemsList = [];

    try {
      await query.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          // if(element.data()['favorites'][0] == FirebaseAuth.instance.currentUser.uid) {
          //   itemsList.add(element.data());
          // }
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

class UserpostManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  final CollectionReference postList =
  FirebaseFirestore.instance
      .collection('propertyDetails');


  Future getUsersPostList() async {
    List itemsList = [];

    try {
      await postList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          if(element.data()['postedById'] == FirebaseAuth.instance.currentUser.uid) {
            itemsList.add(element.data());
          }
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

