import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyFavoritePost extends StatefulWidget {
  @override
  _MyFavoritePostState createState() => _MyFavoritePostState();
}

class _MyFavoritePostState extends State<MyFavoritePost> {
  bool isAnimate = false;

  //final _auth= FirebaseAuth.instance.currentUser;
  List FavoritePostList = [];
  String doc_id;
  var route;
  String doc_id1;
  //bool f1;
  //String id;
  //var abc;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    refreshPage();
  }
  Future<Null> refreshPage() async{
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return ;
    });
  }
  fetchDatabaseList() async {
    dynamic resultant = await FavoritePostManager().getFavoritePostList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        FavoritePostList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Favourite'),
        backgroundColor: Colors.indigo,
      ),
      body:ListView(
        children: [
          SizedBox(height: 15),
          Container(
            child: RefreshIndicator(
              key: refreshKey,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: FavoritePostList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
                            doc_id = FavoritePostList[index]['propertyId'],
                            //print(snapshot.documents[index].documentID)
                            print(doc_id),
                            route = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  propertyDetail(value: doc_id),

                            ),
                            Navigator.of(context).push(route)
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
                                    borderRadius: BorderRadius.only(topLeft: Radius
                                        .circular(20), topRight: Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        FavoritePostList[index]['firstImage'],
                                        width: MediaQuery.of(context).size.width,
                                        fit:BoxFit.fill
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
                                        .width/2,
                                    child: Text(FavoritePostList[index]['projectName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                                      child: Text(FavoritePostList[index]['price'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                            text: FavoritePostList[index]['postedBy'],
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
                                            text: FavoritePostList[index]['city'],
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
                                            text: FavoritePostList[index]['category'],
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
                                            text: FavoritePostList[index]['status'],
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
              onRefresh: refreshPage,
            ),
          ),
        ],
      ),
    );
  }
}
