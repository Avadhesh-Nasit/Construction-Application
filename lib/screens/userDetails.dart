import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/postPropertyDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userDetails extends StatefulWidget {
  final String value;

  const userDetails({Key key, this.value}) : super(key: key);

  @override
  _userDetailsState createState() => _userDetailsState(value);
}

class _userDetailsState extends State<userDetails> {
  final String value;
  List userPostList = [];
  var route;

  // ignore: non_constant_identifier_names
  String doc_id;

  _userDetailsState(this.value);

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await UserpostManager();

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User's Property"),
          backgroundColor: Colors.indigo,
          actions: [
            // RaisedButton(
            //   child: Text(
            //     "Delete User",
            //     style:
            //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0)),
            //   color: Colors.red,
            //   onPressed: () {},
            // )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 15),
            Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: userPostList.length,
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
                                doc_id = userPostList[index]['propertyId'],
                                //print(snapshot.documents[index].documentID)
                                print(doc_id),
                                route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      postPropertyDetail(value: doc_id),
                                ),
                                Navigator.of(context).push(route)
                              },
                            );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 320,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        userPostList[index]['firstImage'],
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill),
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                        userPostList[index]['projectName'],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo)),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 13),
                                  alignment: Alignment.topRight,
                                  height: 20,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                      userPostList[index]['price'] + "/sq ft",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo)),
                                ))
                              ],
                            ),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Posted by : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            // text: "Builder",
                                            text: userPostList[index]
                                                ['postedBy'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Location : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]['city'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Type : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]
                                                ['category'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Status : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userPostList[index]['status'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    deleteUser();
                  },
                  color: Colors.red.shade500,
                  child: Center(child: Text("Delete User", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,)
          ],
        ),
        // Container(
        //   child: RaisedButton(
        //     child: Text("Delete User",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        //     color: Colors.red,
        //     onPressed: (){
        //       delete();
        //     },
        //   ),
        // ),
      ),
    );
  }

  Future<void> delete() async {
    await FirebaseFirestore.instance.collection('Users').doc(value).delete();
    Navigator.of(context).pop();
  }
  // static Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //   _mainCollection.doc(userUid).collection('items').doc(docId);
  //
  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }

  Future<bool> deleteUser(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Are you sure?"),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        delete();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Text("Yes",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Text("No",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

  UserpostManager() async {
    final CollectionReference postList =
        FirebaseFirestore.instance.collection('propertyDetails');

    List itemsList = [];

    try {
      await postList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          if (element.data()['postedById'] == value) {
            itemsList.add(element.data());
          }
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
