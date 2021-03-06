import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/login_screen.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/searchPage.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'changePassword.dart';
class builderPage extends StatefulWidget {
  @override
  _builderPageState createState() => _builderPageState();
}

class _builderPageState extends State<builderPage> {
  final _auth= FirebaseAuth.instance.currentUser;
  String myEmail;
  String myName;
  String myPhone;
  List userProfilesList = [];
  var doc_id;
  var route;


  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.12,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: Colors.indigo
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // child:
                child: Center(child: Text("Hello, ${_auth.displayName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search_Page()));
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(top: 80, left: 30, right: 30),
              //     height: 50,
              //     width: MediaQuery
              //         .of(context)
              //         .size
              //         .width * 0.9,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       color: Colors.white,
              //     ),
              //     padding: EdgeInsets.only(left: 30, top: 15),
              //     child: Text("Search",
              //         style: TextStyle(color: Colors.grey, fontSize: 16)),
              //   ),
              // )
            ],
          ),
          SizedBox(height: 10.0,),
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: userProfilesList.length,
                itemBuilder: (BuildContext context,int index) {
                  return GestureDetector(
                    onTap: () {
                      //   var uid =FirebaseAuth.instance.currentUser.uid;
                      //   var _randomId = FirebaseFirestore.instance.collection('propertyDetails').document(uid);
                      //   print(_randomId);
                      // var firebaseUser =  FirebaseAuth.instance.currentUser;
                      // FirebaseFirestore.instance.collection("propertyDetails").doc(firebaseUser.uid).get().then((value){
                      //   print(value.data());
                      // });
                      FirebaseFirestore.instance
                          .collection('propertyDetails')
                          .get()
                          .then(
                            (QuerySnapshot snapshot) => {
                          // snapshot.documents.forEach((f) {
                          //
                          //   print("documentID---- " + f.reference.documentID);
                          //
                          // }),
                          //     snapshot.documents[index].data(),
                          doc_id = snapshot.docs[index].id,
                          //print(snapshot.documents[index].documentID)
                          print(doc_id),
                          route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                propertyDetail(value: doc_id),

                          ),
                          Navigator.of(context).push(route)
                        },
                      );
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => propertyDetail(doc: doc_id,)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 320,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius
                                      .circular(20), topRight: Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  child: Image.network(
                                      userProfilesList[index]['firstImage'],
                                      width: MediaQuery.of(context).size.width,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 20, top: 20),
                                child: FavoriteButton(
                                  isFavorite: false,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 13),
                                  height: 30,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width/2,
                                  child: Text(userProfilesList[index]['projectName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.indigo)),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 13),
                                    alignment: Alignment.topRight,
                                    height: 20,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width/2,
                                    child: Text(userProfilesList[index]['price']+"/sq ft", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Posted by : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        // text: "Builder",
                                          text: userProfilesList[index]['postedBy'],
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),
                          SizedBox(height: 7),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Location : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: userProfilesList[index]['city'],
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),
                          SizedBox(height: 7),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Type : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: userProfilesList[index]['category'],
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),
                          SizedBox(height: 7),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Status : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: userProfilesList[index]['status'],
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  );

                }),
          ),
        ],
      ),
    );
  }
  Future<bool> signOut() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('email');
    //prefs.remove('phoneNumber');
    await FirebaseAuth.instance.signOut();
  }
  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((value){
        myEmail=value.data()['email'];
        myName=value.data()['name'];
        myPhone=value.data()['mobileNumber'];
        // print(myEmail);
        // print(myName);
        // print(myPhone);
      }).catchError((e){
        print(e);
      });
    }
  }
}
