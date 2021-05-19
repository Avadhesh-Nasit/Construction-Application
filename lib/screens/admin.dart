import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/searchProperty.dart';
import 'package:construction_application/screens/searchUserWithEmail.dart';
import 'package:construction_application/screens/searchUserWithPhoneNumber.dart';
import 'package:construction_application/screens/userDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class admin extends StatefulWidget {
  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  List userProfilesList = [];
  var doc_id;
  var route;
  String myEmail;
  String myName;
  String myPhone;
  String myPhoto;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManagerUser().getUsersList();

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: (myPhoto!=null)?Image.network(
                            myPhoto,
                            fit: BoxFit.fill,
                          ):Image.asset(
                            "image/icon.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
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
                                Text("Admin",style: TextStyle(fontSize: 40.0,color: Colors.indigo,fontWeight: FontWeight.bold),),
                                // SizedBox(height: 5,),
                                // Text("$myPhone",style: TextStyle(fontSize: 15.0,color: Colors.teal),),
                                // SizedBox(height: 5,),
                                // Text("$myEmail",style: TextStyle(fontSize: 12.0,color: Colors.black),),
                                // //Text("${_auth.phoneNumber}",style: TextStyle(fontSize: 15.0),)
                              ],
                            );
                          }
                      ),
                    )
                  ],
                )
            ),

            ListTile(
              title:Row(
                children: [
                  Icon(Icons.home_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Home")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>admin()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.search_sharp),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Search User By Phone Number")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByPhoneNumber()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.search_sharp),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Search Property"),
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchProperty()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.warning_amber_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Reported Property")
                ],
              ),
            ),
            // Divider(color: Colors.indigo,),
            // Container(
            //   height: 70.0,
            //   child: Row(
            //     children: [
            //       Padding(padding: EdgeInsets.only(left: 10.0,)),
            //       Column(
            //         //crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(padding: EdgeInsets.only(top: 10.0)),
            //           Text("Contact Us",style: TextStyle(fontSize: 20.0,),),
            //           SizedBox(height: 3.0,),
            //           Padding(padding: EdgeInsets.only(left: 10.0)),
            //           Text("9988776655",style: TextStyle(fontSize: 15.0,color: Colors.blue),)
            //         ],
            //       ),
            //       SizedBox(width: 132.0,),
            //       Container(
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           image: DecorationImage(
            //               fit: BoxFit.fill,
            //               image: AssetImage("image/call.png",)
            //           ),
            //         ),
            //         height: 30.0,
            //         width: 30.0,
            //       )
            //     ],
            //   ),
            // ),
            Divider(color: Colors.indigo,),
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
            Divider(color: Colors.indigo,),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.logout,),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Log-Out"),
                ],
              ),
              onTap: (){
              },
            )
          ],
        ),
      ),
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
                child: Center(child: Text("Hello Admin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
              ),
              GestureDetector(
                child:Container(
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
                  child: Text("Search By Email",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByEmail()));
                },
              ),
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
                    onTap: (){
                      FirebaseFirestore.instance
                          .collection('Users')
                          .get()
                          .then(
                            (QuerySnapshot snapshot) => {
                          doc_id = snapshot.docs[index].id,
                          print(doc_id),
                          route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                userDetails(value: doc_id),

                          ),
                          Navigator.of(context).push(route)
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 120,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 15.0)),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 150.0,
                                    height: 150.0,
                                    child: (userProfilesList[index]['Image']!="")?Image.network(
                                      userProfilesList[index]['Image'],
                                      fit: BoxFit.fill,
                                    ):Image.asset(
                                      "image/icon.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Name : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            // text: "Builder",
                                              text: userProfilesList[index]['name'],
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Email : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            // text: "Builder",
                                              text: userProfilesList[index]['email'],
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Mobile Number : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            // text: "Builder",
                                              text: userProfilesList[index]['mobileNumber'],
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Role : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            // text: "Builder",
                                              text: userProfilesList[index]['role'],
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                              // Container(
                              //   height: 30.0,
                              //   width: 75.0,
                              //   child: RaisedButton(
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20.0)
                              //     ),
                              //     child: Text("Delete",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              //     color: Colors.red,
                              //     onPressed: (){
                              //     },
                              //   ),
                              // )
                            ],
                          )
                        ],
                      )
                    ),
                  );

                }),
          ),
        ],
      ),
    );
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
        myPhoto=value.data()['Image'];
        // print(myEmail);
        // print(myName);
        // print(myPhone);
      }).catchError((e){
        print(e);
      });
    }
  }
  // void deleteUser() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser;
  //   user.delete();
  // }
}
