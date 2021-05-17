import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
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
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: Colors.indigo,
      ),
      body:Container(
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
                  height: 130,
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
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 200.0,
                            height: 200.0,
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
                      Column(
                        children: [
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
    );
  }
  // void deleteUser() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser;
  //   user.delete();
  // }

}
