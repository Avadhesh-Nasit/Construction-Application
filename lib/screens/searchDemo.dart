// import 'package:algolia/algolia.dart';
// import 'package:flutter/material.dart';
//
// class MyApp12 extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _searchText = TextEditingController(text: "");
//   List<AlgoliaObjectSnapshot> _results = [];
//   bool _searching = false;
//
//   _search() async {
//     setState(() {
//       _searching = true;
//     });
//
//     Algolia algolia = Algolia.init(
//       applicationId: 'construction-3bbef',
//       apiKey: 'AIzaSyACKY1foKZg7BmEKziGU7CnLX6eqzFPsnI',
//     );
//
//     AlgoliaQuery query = algolia.instance.index('propertyDetails');
//     query = query.search(_searchText.text);
//
//     _results = (await query.getObjects()).hits;
//
//     setState(() {
//       _searching = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Algolia Search"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("Search"),
//             TextField(
//               controller: _searchText,
//               decoration: InputDecoration(hintText: "Search query here..."),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 FlatButton(
//                   color: Colors.blue,
//                   child: Text(
//                     "Search",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: _search,
//                 ),
//               ],
//             ),
//             Expanded(
//               child: _searching == true
//                   ? Center(
//                 child: Text("Searching, please wait..."),
//               )
//                   : _results.length == 0
//                   ? Center(
//                 child: Text("No results found."),
//               )
//                   : ListView.builder(
//                 itemCount: _results.length,
//                 itemBuilder: (BuildContext ctx, int index) {
//                   AlgoliaObjectSnapshot snap = _results[index];
//
//                   return ListTile(
//                     leading: CircleAvatar(
//                       child: Text(
//                         (index + 1).toString(),
//                       ),
//                     ),
//                     title: Text(snap.data["projectName"]),
//                     subtitle: Text(snap.data["postedBy"]),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// class MyApp12 extends StatefulWidget {
//   @override
//   _MyApp12State createState() => _MyApp12State();
// }
//
// class _MyApp12State extends State<MyApp12> {
//   String status = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             onChanged: (val) => initiateSearch(val),
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: status != "" && status != null
//               ? FirebaseFirestore.instance
//               .collection('propertyDetails')
//               .where('postedBy', arrayContains: status)
//               .snapshots()
//               : FirebaseFirestore.instance.collection("propertyDetails").snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return new Text('Loading...');
//               default:
//                 return new ListView(
//                   children:
//                   snapshot.data.docs.map((DocumentSnapshot document) {
//                     return new ListTile(
//                       title: new Text(document['status']),
//                       subtitle: new Text(document['postedBy']),
//                     );
//                   }).toList(),
//                 );
//             }
//           },
//         ),
//       ),
//     );
//   }
//   void initiateSearch(String val) {
//     setState(() {
//       status = val;
//     });
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/databaseManager.dart';
import 'package:construction_application/screens/propertyDetail.dart';
///////////*****************/////////////
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:construction_application/models/databaseManager.dart';
// import 'package:flutter/material.dart';
//
// class MyApp12 extends StatefulWidget {
//   @override
//   _MyApp12State createState() => _MyApp12State();
// }
//
// class _MyApp12State extends State<MyApp12> {
//   var queryResultSet = [];
//   var tempSearchStore=[];
//   initiateSearch(value){
//     if(value.length == 0){
//       setState(() {
//         queryResultSet=[];
//         tempSearchStore=[];
//       });
//     }
//     var capitalizedValue = value.subString(0,1).toUpperCase() + value.subString(1);
//     if(queryResultSet.length==0 && value.length == 1){
//         SearchService().searchByName(value).then((QuerySnapshot docs){
//           for(int i=0;i<docs.documents.length;++i){
//             queryResultSet.add(docs.documents[i].data());
//           }
//         });
//     }
//     else{
//       tempSearchStore=[];
//       queryResultSet.forEach((element) {
//         if(element['city'].startWith(capitalizedValue)){
//           setState(() {
//             tempSearchStore.add(element);
//           });
//         }
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: (val){
//                 initiateSearch(val);
//               },
//               decoration: InputDecoration(
//                   prefixIcon:IconButton(
//                     color: Colors.black,
//                     icon: Icon(Icons.arrow_back_ios),
//                     iconSize: 20.0,
//                     onPressed: (){
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   contentPadding: EdgeInsets.only(left: 25.0),
//                   hintText: "Search by Name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4.0),
//                   )
//               ),
//             ),
//           ),
//           SizedBox(height: 10.0,),
//           GridView.count(
//               padding: EdgeInsets.only(left: 10.0,right: 10.0),
//               crossAxisCount: 2,
//               crossAxisSpacing: 4.0,
//               mainAxisSpacing: 4.0,
//               primary: false,
//               shrinkWrap: true,
//               children:tempSearchStore.map((element){
//                 return buildResultCard(element);
//               }).toList()
//           )
//         ],
//       ),
//     );
//   }
//   Widget buildResultCard(data){
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       elevation: 2.0,
//       child: Container(
//         child: Center(
//           child: Text(data['city'],
//           textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//                 fontSize: 20.0
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';

class SearchFeed extends StatefulWidget {
  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  var doc_id;
  var route;
  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'propertyDetails',
      searchBy: 'city',
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel> dataList = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: ListView.builder(
                itemCount: dataList?.length ?? 0,
                itemBuilder: (context, index) {
                  final DataModel data = dataList[index];

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
