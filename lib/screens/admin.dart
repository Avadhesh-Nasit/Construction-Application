import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/searchUserWithEmail.dart';
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
     // backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
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
  // void deleteUser() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser;
  //   user.delete();
  // }
}
