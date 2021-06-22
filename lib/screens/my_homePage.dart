import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/models/firebase.dart';
import 'package:construction_application/screens/login_screen.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/searchPage.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate_my_app/rate_my_app.dart';

class myHomepage extends StatefulWidget {

  @override
  _myHomepageState createState() => _myHomepageState();
}

class _myHomepageState extends State<myHomepage> {
  final _auth= FirebaseAuth.instance.currentUser;
  int view2;
  String myEmail;
  String myName;
  String myPhone;
  List userProfilesList = [];
  String f1;
  var doc_id;
  var route;
  String i1;
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    // googlePlayIdentifier: 'fr.skyost.example',
    // appStoreIdentifier: '1491556149',
  );

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this app', // The dialog title.
          message: 'Help us to improve our app.', // The dialog message.
          rateButton: 'RATE', // The dialog "rate" button text.
          noButton: 'NO THANKS', // The dialog "no" button text.
          laterButton: 'MAYBE LATER', // The dialog "later" button text.
          listener: (button) { // The button click listener (useful if you want to cancel the click event).
            switch(button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          dialogStyle: const DialogStyle(), // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );

      }
    });
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
        backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo,
      //   elevation: 0.0,
      //   // actions: [
      //   //   IconButton(icon: Icon(Icons.person),
      //   //       onPressed: (){
      //   //     signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
      //   //       }
      //   //   )
      //   // ],
      // ),
      body:ListView(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search_Page()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                          height: 50,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 30, top: 15),
                          child: Text("Search",
                              style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
          SizedBox(height: 10.0,),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("Available property(${userProfilesList.length})",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 5),
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
                                      view2 = snapshot.docs[index].get('view'),
                                      if(snapshot.docs[index].get('postedById') == FirebaseAuth.instance.currentUser.uid) {
                                        view2 = view2
                                      } else {
                                        view2 = view2+1
                                      },
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
                               propertyDetail(value: doc_id,u2:i1,v1:view2),
                              ),
                                      i1=snapshot.documents[index].get('postedById'),
                                    Navigator.of(context).push(route),

                                      FirebaseFirestore.instance.collection('propertyDetails').doc(doc_id).updateData(
                                          {'view':view2,}),

                                },
                              );
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => propertyDetail(doc: doc_id,)));
                              },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              height: 350,
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
                                            if(_isFavorite == true) {
                                            FirebaseFirestore.instance
                                                .collection('propertyDetails')
                                                .get()
                                                .then(
                                            (QuerySnapshot snapshot) =>
                                            {
                                            // snapshot.documents.forEach((f) {
                                            //    id = f.reference.documentID;
                                            //   //print("documentID---- " + f.reference.documentID);
                                            //
                                            // }),
                                            // print(snapshot.docs[index].documentID),
                                            //snapshot.docs[index].data(),
                                            f1 = snapshot.documents[index].documentID,
                                            // doc_id1 = snapshot.documents[index].documentID,
                                            // //print(snapshot.documents[index].documentID)
                                            Firestore.instance.collection('propertyDetails').doc(f1).set({
                                            'favorites': FieldValue.arrayUnion(['${FirebaseAuth.instance.currentUser.uid}']),
                                            'propertyId': '$f1'
                                            },SetOptions(merge: true)).then((value) =>
                                            {})
                                            });
                                            } else {
                                            FirebaseFirestore.instance
                                                .collection('propertyDetails')
                                                .get()
                                                .then(
                                            (QuerySnapshot snapshot) => {
                                            f1 = snapshot.documents[index].documentID,
                                            Firestore.instance.collection('propertyDetails').doc(f1).set({
                                            'favorites': FieldValue.arrayRemove(['${FirebaseAuth.instance.currentUser.uid}'])
                                            },SetOptions(merge: true)).then((value) => {})
                                            });
                                            }
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
                                            child: Text('₹'+userProfilesList[index]['price'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
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
                                         Spacer(),
                                         Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(left: 13),
                                            child: RichText(
                                              text: TextSpan(
                                                  text: userProfilesList[index]['area'],
                                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                                  // children: [
                                                  //   TextSpan(
                                                  //     // text: "Builder",
                                                  //       text: userProfilesList[index]['area'],
                                                  //       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                                  //   )
                                                  // ]
                                              ),
                                            )
                                      ),
                                    ],
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
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
                                      ),
                                      Expanded(
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(right: 13),
                                            child: Text(
                                              userProfilesList[index]['markAsSold'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: userProfilesList[index]
                                                  ['markAsSold'] ==
                                                      'Sold'
                                                      ? Colors.red
                                                      : Colors.green),
                                            ),
                                          ))
                                    ],
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
      // ListView(
      //   // child: Center(child: Text("${_auth.displayName}")),
      //   children: [
      //     Column(
      //       children: [
      //         Stack(
      //           children: [
      //             Container(
      //               height: MediaQuery
      //                   .of(context)
      //                   .size
      //                   .height * 0.12,
      //               width: MediaQuery
      //                   .of(context)
      //                   .size
      //                   .width,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.only(
      //                       bottomRight: Radius.circular(30),
      //                       bottomLeft: Radius.circular(30)),
      //                   color: Colors.indigo
      //               ),
      //             ),
      //             Container(
      //               margin: EdgeInsets.only(top: 15),
      //               // child:
      //               child: Center(child: Text("Hello, ${_auth.displayName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search_Page()));
      //               },
      //               child: Container(
      //                 margin: EdgeInsets.only(top: 80, left: 30, right: 30),
      //                 height: 50,
      //                 width: MediaQuery
      //                     .of(context)
      //                     .size
      //                     .width * 0.9,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(30),
      //                   color: Colors.white,
      //                 ),
      //                 padding: EdgeInsets.only(left: 30, top: 15),
      //                 child: Text("Search",
      //                     style: TextStyle(color: Colors.grey, fontSize: 16)),
      //               ),
      //             )
      //           ],
      //         ),
      //         SizedBox(height: 30),
      //         // GestureDetector(
      //         //   onTap: () {
      //         //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
      //         //   },
      //         //   child: Container(
      //         //     height: 280,
      //         //     width: MediaQuery
      //         //         .of(context)
      //         //         .size
      //         //         .width * 0.9,
      //         //     decoration: BoxDecoration(
      //         //         color: Colors.indigo.shade300,
      //         //         borderRadius: BorderRadius.circular(20)
      //         //     ),
      //         //     child: Column(
      //         //       children: [
      //         //         Stack(
      //         //           children: [
      //         //             Container(
      //         //               height: 140,
      //         //               decoration: BoxDecoration(
      //         //                   borderRadius: BorderRadius.only(topLeft: Radius
      //         //                       .circular(20), topRight: Radius.circular(20)),
      //         //                   color: Colors.white
      //         //               ),
      //         //               // child: Image(image: AssetImage(""), fit: BoxFit.cover),
      //         //             ),
      //         //             Container(
      //         //               alignment: Alignment.topRight,
      //         //               margin: EdgeInsets.only(right: 20, top: 20),
      //         //               child: FavoriteButton(
      //         //                 isFavorite: false,
      //         //                 valueChanged: (_isFavorite) {
      //         //                   print('Is Favorite : $_isFavorite');
      //         //                 },
      //         //               ),
      //         //             ),
      //         //           ],
      //         //         ),
      //         //         Row(
      //         //           children: [
      //         //             Container(color: Colors.yellow,
      //         //                 height: 30,
      //         //                 width: MediaQuery
      //         //                     .of(context)
      //         //                     .size
      //         //                     .width * 0.45),
      //         //             Container(
      //         //                 color: Colors.red, height: 30, width: MediaQuery
      //         //                 .of(context)
      //         //                 .size
      //         //                 .width * 0.45)
      //         //           ],
      //         //         )
      //         //       ],
      //         //     ),
      //         //   ),
      //         // ),
      //         GestureDetector(
      //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => propertyDetail())),
      //           child: Container(
      //             height: 300,
      //             width: MediaQuery
      //                 .of(context)
      //                 .size
      //                 .width * 0.9,
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(20)
      //             ),
      //             child: Column(
      //               children: [
      //                 Stack(
      //                   children: [
      //                     Container(
      //                       height: 160,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.only(topLeft: Radius
      //                             .circular(20), topRight: Radius.circular(20)),
      //                       ),
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.only(
      //                           topLeft: Radius.circular(20.0),
      //                           topRight: Radius.circular(20.0),
      //                         ),
      //                         child: Image.asset(
      //                             'image/home.jpg',
      //                             width: MediaQuery.of(context).size.width,
      //                             fit:BoxFit.fill
      //                         ),
      //                       ),
      //                     ),
      //                     Container(
      //                       alignment: Alignment.topRight,
      //                       margin: EdgeInsets.only(right: 20, top: 20),
      //                       child: FavoriteButton(
      //                         isFavorite: false,
      //                         valueChanged: (_isFavorite) {
      //                           print('Is Favorite : $_isFavorite');
      //                         },
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //                 SizedBox(height: 5),
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: Container(
      //                         margin: EdgeInsets.only(left: 13),
      //                         height: 20,
      //                         width: MediaQuery
      //                             .of(context)
      //                             .size
      //                             .width/2,
      //                         child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //                       ),
      //                     ),
      //                     Expanded(
      //                         child: Container(
      //                           margin: EdgeInsets.only(right: 13),
      //                           alignment: Alignment.topRight,
      //                           height: 20,
      //                           width: MediaQuery
      //                               .of(context)
      //                               .size
      //                               .width/2,
      //                           child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
      //                         )
      //                     )
      //                   ],
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                     alignment: Alignment.topLeft,
      //                     margin: EdgeInsets.only(left: 13),
      //                     child: RichText(
      //                       text: TextSpan(
      //                           text: "Posted by : ",
      //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      //                           children: [
      //                             TextSpan(
      //                               // text: "Builder",
      //                                 text: "Builder",
      //                                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
      //                             )
      //                           ]
      //                       ),
      //                     )
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                     alignment: Alignment.topLeft,
      //                     margin: EdgeInsets.only(left: 13),
      //                     child: RichText(
      //                       text: TextSpan(
      //                           text: "Location : ",
      //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      //                           children: [
      //                             TextSpan(
      //                                 text: "Surat",
      //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
      //                             )
      //                           ]
      //                       ),
      //                     )
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                     alignment: Alignment.topLeft,
      //                     margin: EdgeInsets.only(left: 13),
      //                     child: RichText(
      //                       text: TextSpan(
      //                           text: "Type : ",
      //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      //                           children: [
      //                             TextSpan(
      //                                 text: "Residential",
      //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
      //                             )
      //                           ]
      //                       ),
      //                     )
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                     alignment: Alignment.topLeft,
      //                     margin: EdgeInsets.only(left: 13),
      //                     child: RichText(
      //                       text: TextSpan(
      //                           text: "Status : ",
      //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      //                           children: [
      //                             TextSpan(
      //                                 text: "Under Construction",
      //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
      //                             )
      //                           ]
      //                       ),
      //                     )
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
      //           },
      //           child: Container(
      //             height: 280,
      //             width: MediaQuery
      //                 .of(context)
      //                 .size
      //                 .width * 0.9,
      //             decoration: BoxDecoration(
      //                 color: Colors.indigo.shade300,
      //                 borderRadius: BorderRadius.circular(20)
      //             ),
      //             child: Column(
      //               children: [
      //                 Stack(
      //                   children: [
      //                     Container(
      //                       height: 140,
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.only(topLeft: Radius
      //                               .circular(20), topRight: Radius.circular(20)),
      //                           color: Colors.white
      //                       ),
      //                       // child: Image(image: AssetImage(""), fit: BoxFit.cover),
      //                     ),
      //                     Container(
      //                       alignment: Alignment.topRight,
      //                       margin: EdgeInsets.only(right: 20, top: 20),
      //                       child: FavoriteButton(
      //                         isFavorite: false,
      //                         valueChanged: (_isFavorite) {
      //                           print('Is Favorite : $_isFavorite');
      //                         },
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     Container(color: Colors.yellow,
      //                         height: 30,
      //                         width: MediaQuery
      //                             .of(context)
      //                             .size
      //                             .width * 0.45),
      //                     Container(
      //                         color: Colors.red, height: 30, width: MediaQuery
      //                         .of(context)
      //                         .size
      //                         .width * 0.45)
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
      //           },
      //           child: Container(
      //             height: 280,
      //             width: MediaQuery
      //                 .of(context)
      //                 .size
      //                 .width * 0.9,
      //             decoration: BoxDecoration(
      //                 color: Colors.indigo.shade300,
      //                 borderRadius: BorderRadius.circular(20)
      //             ),
      //             child: Column(
      //               children: [
      //                 Stack(
      //                   children: [
      //                     Container(
      //                       height: 140,
      //                       decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.only(topLeft: Radius
      //                               .circular(20), topRight: Radius.circular(20)),
      //                           color: Colors.white
      //                       ),
      //                       // child: Image(image: AssetImage(""), fit: BoxFit.cover),
      //                     ),
      //                     Container(
      //                       alignment: Alignment.topRight,
      //                       margin: EdgeInsets.only(right: 20, top: 20),
      //                       child: FavoriteButton(
      //                         isFavorite: false,
      //                         valueChanged: (_isFavorite) {
      //                           print('Is Favorite : $_isFavorite');
      //                         },
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     Container(color: Colors.yellow,
      //                         height: 30,
      //                         width: MediaQuery
      //                             .of(context)
      //                             .size
      //                             .width * 0.45),
      //                     Container(
      //                         color: Colors.red, height: 30, width: MediaQuery
      //                         .of(context)
      //                         .size
      //                         .width * 0.45)
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         )
      //       ],
      //     )
      //   ],
      // ),
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
  Future<void> resetpassword(){
    User _auth = FirebaseAuth.instance.currentUser;
    _auth.sendEmailVerification();

  }
  // login() async{
  //   final firebaseUser = await FirebaseAuth.instance.currentUser;
  //   if(firebaseUser==null){
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
  //   }
  // }
}
