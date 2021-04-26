import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:flutter/material.dart';

class searchByStatus extends StatefulWidget {
  @override
  _searchByStatusState createState() => _searchByStatusState();
}

class _searchByStatusState extends State<searchByStatus> {
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
              prefixIcon: Icon(Icons.search), hintText: 'Search...',

            ),
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
            .collection('propertyDetails')
            .where('status', isEqualTo: name)
            .snapshots()
            : FirebaseFirestore.instance.collection('propertyDetails').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return GestureDetector(
                onTap: (){
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
                      doc_id = data['propertyId'],
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 175,
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
                                  data['firstImage'],
                                  width: MediaQuery.of(context).size.width,
                                  fit:BoxFit.fill
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        height: 30,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width/2,
                        child: Text(data['projectName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.indigo)),
                      ),
                      SizedBox(height: 5,),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 13),
                          child: RichText(
                            text: TextSpan(
                                text: "PostedBy : ",
                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    // text: "Builder",
                                      text:data['postedBy'],
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                  )
                                ]
                            ),
                          )
                      ),
                      SizedBox(height: 5,),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 13),
                          child: RichText(
                            text: TextSpan(
                                text: "City : ",
                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    // text: "Builder",
                                      text:data['city'],
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                  )
                                ]
                            ),
                          )
                      ),
                      SizedBox(height: 5,),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 13),
                          child: RichText(
                            text: TextSpan(
                                text: "Property Type : ",
                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    // text: "Builder",
                                      text:data['category'],
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                  )
                                ]
                            ),
                          )
                      ),
                      SizedBox(height: 5,),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 13),
                          child: RichText(
                            text: TextSpan(
                                text: "Status : ",
                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    // text: "Builder",
                                      text:data['status'],
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                  )
                                ]
                            ),
                          )
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              );
              //   Card(
              //   child: Row(
              //     children: <Widget>[
              //       Image.network(
              //         data['firstImage'],
              //         width: 150,
              //         height: 100,
              //         fit: BoxFit.fill,
              //       ),
              //       SizedBox(
              //         width: 25,
              //       ),
              //       Text(
              //         data['projectName'],
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          );
        },
      ),
    );
  }

}
