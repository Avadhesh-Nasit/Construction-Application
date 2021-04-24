import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';

class searchByCategory extends StatefulWidget {
  @override
  _searchByCategoryState createState() => _searchByCategoryState();
}

class _searchByCategoryState extends State<searchByCategory> {
  var doc_id;
  var route;
  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'propertyDetails',
      searchBy: 'category',
      dataListFromSnapshot: DataModel1().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel1> dataList = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: ListView.builder(
                itemCount: dataList?.length ?? 0,
                itemBuilder: (context, index) {
                  final DataModel1 data = dataList[index];

                  return GestureDetector(
                    onTap: (){
                      FirebaseFirestore.instance
                          .collection('propertyDetails')
                          .get()
                          .then(
                            (QuerySnapshot snapshot) => {

                          doc_id = snapshot.docs[index].id,
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
                                      '${data?.firstImage ?? ''}',
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
                            child: Text('${data?.name ?? ''}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.indigo)),
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
                                          text:'${data?.postedBy ?? ''}',
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
                                          text:'${data?.city ?? ''}',
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
                                          text:'${data?.category ?? ''}',
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
                                          text:'${data?.status ?? ''}',
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
                }),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
