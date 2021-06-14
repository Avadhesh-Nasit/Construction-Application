import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/userDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_Search extends StatefulWidget {
  final String ms;
  const Mobile_Search({Key key, this.ms}) : super(key: key);

  @override
  _Mobile_SearchState createState() => _Mobile_SearchState();
}

class _Mobile_SearchState extends State<Mobile_Search> {
  List userProfilesList = [];
  var doc_id;
  var route;
  String myEmail;
  String myName;
  String myPhone;
  String myPhoto;
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManagerUser1().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  List mobileListResult = [];
  final Query query3 = FirebaseFirestore
      .instance
      .collection("Users")
      .where("mobileNumber", isEqualTo: "2516256511");

  Future getMobileWithSearch() async {
    List mobileList = [];
    try {
      await query3.getDocuments().then((querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          mobileList.add(element.data());
        })
      });
      return mobileList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchMobileList() async {
    dynamic mobileResult = await getMobileWithSearch();

    if(mobileResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        mobileListResult = mobileResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMobileList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: (widget.ms != "" && widget.ms != null)
            ? FirebaseFirestore
            .instance
            .collection("Users")
            .where('mobileNumber', isEqualTo: widget.ms)
            .snapshots()
            : FirebaseFirestore
            .instance
            .collection("Users12")
            .where('role', isNotEqualTo: 'Admin')
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance
                            .collection('Users')
                            .get()
                            .then(
                              (QuerySnapshot snapshot) => {
                            doc_id = data['userId'],
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
                        margin: EdgeInsets.all(5),
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: CircleAvatar(
                                radius: 30,
                                child: Text(
                                  data['name'][0],
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      data['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    child: Text(
                                      data['email'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    child: Text(
                                      data['role'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
          );
        }
      ),
    );
  }
}
