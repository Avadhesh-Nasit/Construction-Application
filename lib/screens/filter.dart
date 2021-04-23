import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:flutter/material.dart';
class filter extends StatefulWidget {
  final String state;
  final String city;
  final String sellOrRent;
  final String propertyType;
  final String status;
  final String postedBy;
  final String city1;
  final String state1;


  const filter({Key key, this.state,this.city,this.sellOrRent,this.propertyType,this.status,this.postedBy,this.state1,this.city1}) : super(key: key);
  @override
  _filterState createState() => _filterState(state,city,sellOrRent,propertyType,status,postedBy,state1,city1);
}

class _filterState extends State<filter> {
  final String state;
  final String city;
  final String sellOrRent;
  final String propertyType;
  final String status;
  final String postedBy;
  final String state1;
  final String city1;

  _filterState(this.state, this.city,this.sellOrRent,this.propertyType,this.status,this.postedBy,this.city1,this.state1);
  @override
  List userProfilesList = [];

  void initState() {
    super.initState();
    fetchDatabaseList();
  }
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager1().getUsersList(state,city,sellOrRent,propertyType,status,postedBy);
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }
  // fetchDatabaseList1() async {
  //   dynamic resultant = await DatabaseManager2().getUsersList(state1,city1);
  //   if (resultant == null) {
  //     print('Unable to retrieve');
  //   } else {
  //     setState(() {
  //       userProfilesList = resultant;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body:ListView(
        children: [
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: userProfilesList.length,
                itemBuilder: (BuildContext context,int index) {
                  return GestureDetector(
                    onTap: () {
                     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
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
                                      userProfilesList[index]['firstImage'],
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
                                  child: Text(userProfilesList[index]['projectName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.indigo)),
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
                                    child: Text(userProfilesList[index]['price']+"/sq ft", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 10),
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
                                          text: userProfilesList[index]['postedBy'],
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
                                          text: userProfilesList[index]['city'],
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
                                          text: userProfilesList[index]['category'],
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
                                          text: userProfilesList[index]['status'],
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
          ),
        ],
      ),
    );
  }
}
