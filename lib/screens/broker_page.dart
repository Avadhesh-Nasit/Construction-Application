import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/main.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'changePassword.dart';
import 'login_screen.dart';
class brokerPage extends StatefulWidget {
  @override
  _brokerPageState createState() => _brokerPageState();
}

class _brokerPageState extends State<brokerPage> {
  final _auth= FirebaseAuth.instance.currentUser;
  String myEmail;
  String myName;
  String myPhone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Column(
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
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
                  },
                  child: Container(
                    height: 280,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius
                                      .circular(20), topRight: Radius.circular(20)),
                                  color: Colors.white
                              ),
                              // child: Image(image: AssetImage(""), fit: BoxFit.cover),
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
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(color: Colors.yellow,
                                height: 30,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45),
                            Container(
                                color: Colors.red, height: 30, width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.45)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
                  },
                  child: Container(
                    height: 280,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius
                                      .circular(20), topRight: Radius.circular(20)),
                                  color: Colors.white
                              ),
                              // child: Image(image: AssetImage(""), fit: BoxFit.cover),
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
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(color: Colors.yellow,
                                height: 30,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45),
                            Container(
                                color: Colors.red, height: 30, width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.45)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )
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
