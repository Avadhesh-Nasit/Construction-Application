import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/userPropertyDetail.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  bool isAnimate = false;

  //final _auth= FirebaseAuth.instance.currentUser;
  List userPostList = [];
  String doc_id;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    refreshPage();
  }

  Future<Null> refreshPage() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return;
    });
  }

  fetchDatabaseList() async {
    dynamic resultant = await UserpostManager().getUserPostList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userPostList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            child: RefreshIndicator(
              key: refreshKey,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: userPostList.length,
                  itemBuilder: (context, index) {
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
                            .collection('Users')
                            .document(FirebaseAuth.instance.currentUser.uid)
                            .collection('usersPost')
                            .get()
                            .then(
                              (QuerySnapshot snapshot) =>
                          {
                            // snapshot.documents.forEach((f) {
                            //
                            //   print("documentID---- " + f.reference.documentID);
                            //
                            // }),
                            //     snapshot.documents[index].data(),
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    userPropertyDetail(value: doc_id))),
                            doc_id = snapshot.docs[index].id,
                            print(doc_id)
                          },
                        );
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius
                                            .circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        userPostList[index]['firstImage'],
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                ),
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
                                        .width / 2,
                                    child: Text(
                                        userPostList[index]['projectName'],
                                        style: TextStyle(fontSize: 25,
                                            fontWeight: FontWeight.bold)),
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
                                          .width / 2,
                                      child: Text(userPostList[index]['price'],
                                          style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo)),
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
                                      style: TextStyle(fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          // text: "Builder",
                                            text: userPostList[index]['postedBy'],
                                            style: TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.w400)
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
                                      style: TextStyle(fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]['city'],
                                            style: TextStyle(fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400)
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
                                      style: TextStyle(fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]['category'],
                                            style: TextStyle(fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400)
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
                                      style: TextStyle(fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]['status'],
                                            style: TextStyle(fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400)
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
              onRefresh: refreshPage,
            ),
          ),
        ],
      ),
    );
  }
}
