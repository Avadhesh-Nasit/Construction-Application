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
                                      .where('postedBy',isEqualTo: postedBy);

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
// class DatabaseManager2 {
//
//   Future getUsersList(String state,String city) async {
//     List itemsList = [];
//     final profileList =
//     FirebaseFirestore.instance
//         .collection('propertyDetails').where('state',isEqualTo: state)
//         .where('city',isEqualTo:city);
//
//
//     try {
//       await profileList.getDocuments().then((querySnapshot) {
//         querySnapshot.documents.forEach((element) {
//           itemsList.add(element.data());
//         });
//       });
//       return itemsList;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }

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

class SearchService{
  searchByName(String searchField){
    return FirebaseFirestore.instance.collection('propertyDetails')
        .where('city',isEqualTo: searchField.substring(0,1).toUpperCase()).get();

  }
}

class DatabaseManagerUser {
  final CollectionReference profileList =
  FirebaseFirestore.instance
      .collection('Users');


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

class DataModel {
  final String postedBy;
  final String city;
  final String category;
  final String status;
  final String firstImage;
  final String name;

  DataModel({this.postedBy, this.city,this.category,this.status,this.firstImage,this.name});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
  return querySnapshot.docs.map((snapshot) {
  final Map<String, dynamic> dataMap = snapshot.data();

  return DataModel(
  postedBy: dataMap['postedBy'], city: dataMap['city'],category:dataMap['category'],status: dataMap['status'],firstImage: dataMap['firstImage'],name: dataMap['projectName'] );
  }).toList();
  }
}
class DataModel1{
  final String postedBy;
  final String city;
  final String category;
  final String status;
  final String firstImage;
  final String name;

  DataModel1({this.postedBy, this.city,this.category,this.status,this.firstImage,this.name});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel1> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return DataModel1(
          postedBy: dataMap['postedBy'], city: dataMap['city'],category:dataMap['category'],status: dataMap['status'],firstImage: dataMap['firstImage'],name: dataMap['projectName'] );
    }).toList();
  }
}
class DataModelpostedBy{
  final String postedBy;
  final String city;
  final String category;
  final String status;
  final String firstImage;
  final String name;

  DataModelpostedBy({this.postedBy, this.city,this.category,this.status,this.firstImage,this.name});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModelpostedBy> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return DataModelpostedBy(
          postedBy: dataMap['postedBy'], city: dataMap['city'],category:dataMap['category'],status: dataMap['status'],firstImage: dataMap['firstImage'],name: dataMap['projectName'] );
    }).toList();
  }
}
class DataModellandmark{
  final String postedBy;
  final String city;
  final String category;
  final String status;
  final String firstImage;
  final String name;

  DataModellandmark({this.postedBy, this.city,this.category,this.status,this.firstImage,this.name});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModellandmark> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return DataModellandmark(
          postedBy: dataMap['postedBy'], city: dataMap['city'],category:dataMap['category'],status: dataMap['status'],firstImage: dataMap['firstImage'],name: dataMap['projectName'] );
    }).toList();
  }
}

class newProject {
  final CollectionReference profileList =
  FirebaseFirestore.instance
      .collection('newProject');


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





