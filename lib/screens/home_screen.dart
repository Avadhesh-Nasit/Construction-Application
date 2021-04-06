import 'package:construction_application/screens/login_screen.dart';
import 'package:construction_application/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:construction_application/models/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // actions: [
        //   IconButton(icon: Icon(Icons.person),
        //       onPressed: (){
        //     signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
        //       }
        //   )
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("image/icon.png")
                            )
                        ),
                        height: 100.0,
                        width: 100.0,
                      ),
                      SizedBox(width: 20.0,),
                      Container(
                        child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState!=ConnectionState.done){
                              return Text("Loading....");
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 45.0)),
                                Text("$myName",style: TextStyle(fontSize: 20.0),),
                                SizedBox(height: 5,),
                                Text("$myEmail",style: TextStyle(fontSize: 15.0),),
                                SizedBox(height: 5,),
                                Text("$myPhone",style: TextStyle(fontSize: 15.0),),
                                //Text("${_auth.phoneNumber}",style: TextStyle(fontSize: 15.0),)
                              ],
                            );
                          }
                        ),
                      )
                    ],
                  )
              ),
            //),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.home_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Home")
                ],
              ),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.add_box_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Post Property")
                ],
              ),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.calculate_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("EMI Calculator")
                ],
              ),
            ),
            Divider(),
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0,)),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text("Contact Us",style: TextStyle(fontSize: 20.0,),),
                      SizedBox(height: 3.0,),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text("9988776655",style: TextStyle(fontSize: 15.0),)
                    ],
                  ),
                  SizedBox(width: 132.0,),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("image/call.png")
                        )
                    ),
                    height: 30.0,
                    width: 30.0,
                  )
                ],
              ),
            ),
            Divider(),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.info_outline),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("About Us")
                ],
              ),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.privacy_tip_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Privacy Policy")
                ],
              ),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.announcement_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Terms & Condition")
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 88.0,),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.logout),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Log-Out"),
                ],
              ),
              onTap: (){
                signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
              },
            )
          ],
        ),
      ),
      body: ListView(
        // child: Center(child: Text("${_auth.displayName}")),
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
                  GestureDetector(
                    onTap: () {},
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
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
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
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
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
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
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
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
      ),
    );
  }
  Future<bool> signOut() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('email');
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
