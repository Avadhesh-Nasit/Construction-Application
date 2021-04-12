import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/searchPage.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myHomepage extends StatefulWidget {
  @override
  _myHomepageState createState() => _myHomepageState();
}

class _myHomepageState extends State<myHomepage> {
  final _auth= FirebaseAuth.instance.currentUser;
  String myEmail;
  String myName;
  String myPhone;
  List userProfilesList = [];
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
          Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                 physics: ScrollPhysics(),
                      itemCount: userProfilesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => propertyDetail())),
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
                                            userProfilesList[index]['url'],
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
                                        child: Text(userProfilesList[index]['projectName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                                          child: Text(userProfilesList[index]['price'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: 7),
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
      )
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
}