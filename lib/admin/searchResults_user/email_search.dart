import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/userDetails.dart';
import 'package:flutter/material.dart';

class Email_Search extends StatefulWidget {
  final String es;
  const Email_Search({Key key, this.es}) : super(key: key);

  @override
  _Email_SearchState createState() => _Email_SearchState();
}

class _Email_SearchState extends State<Email_Search> {
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

  List emailListResult = [];
  final Query query2 = FirebaseFirestore
      .instance
      .collection("Users")
      .where("email", isEqualTo: "builder@gmail.com");

  Future getEmailWithSearch() async {
    List emailList = [];
    try {
      await query2.getDocuments().then((querySnapshot) => {
        querySnapshot.documents.forEach((element) {
          emailList.add(element.data());
        })
      });
      return emailList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchEmailList() async {
    dynamic emailResult = await getEmailWithSearch();

    if(emailResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        emailListResult = emailResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmailList();
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: (widget.es != "" && widget.es != null)
            ? FirebaseFirestore
            .instance
            .collection("Users")
            .where('email', isEqualTo: widget.es)
            .snapshots()
            : FirebaseFirestore
            .instance
            .collection("Users")
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
