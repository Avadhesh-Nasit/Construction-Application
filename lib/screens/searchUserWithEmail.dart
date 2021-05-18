import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/userDetails.dart';
import 'package:flutter/material.dart';

class searchByEmail extends StatefulWidget {
  @override
  _searchByEmailState createState() => _searchByEmailState();
}

class _searchByEmailState extends State<searchByEmail> {
  String name = "";
  var doc_id;
  var route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: name)
            .snapshots()
            : FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context,int index) {
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
                                    child: (data['Image']!="")?Image.network(
                                      data['Image'],
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
                                              text: data['name'],
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
                                              text: data['email'],
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
                                              text: data['mobileNumber'],
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
                                              text: data['role'],
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

              });
        },
      ),
    );
  }

}
