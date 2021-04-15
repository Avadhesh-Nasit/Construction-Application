import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'my_homePage.dart';
class propertyDetail extends StatefulWidget {
  //final String doc;
  //const propertyDetail({Key key, this.doc}) : super(key: key);
  final String value;

  const propertyDetail({Key key, this.value}) : super(key: key);

  @override
  _propertyDetailState createState() => _propertyDetailState(value);
}

class _propertyDetailState extends State<propertyDetail> {
  final String value;
  _propertyDetailState(this.value);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String doc=doc_id;
    return StreamBuilder(
      stream:FirebaseFirestore.instance.collection("propertyDetails").doc(value).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userData = snapshot.data;
        return Scaffold(
          // appBar: AppBar(
          //   elevation: 0.0,
          //   backgroundColor: Colors.indigo,
          // ),
          backgroundColor: Colors.blue.shade50,
          body: Container(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 320,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                  options: CarouselOptions(
                                    height: 300.0,
                                    enlargeCenterPage: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlay: true,
                                    //aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    //enableInfiniteScroll: true,
                                    autoPlayAnimationDuration: Duration(milliseconds:1000),
                                    //viewportFraction: 0.8,
                                  ),
                                  items: [
                                    // Container(
                                    //   child: ClipRRect(
                                    //     child: Image.asset(
                                    //         'image/home.jpg',
                                    //         width: MediaQuery.of(context).size.width,
                                    //         height: MediaQuery.of(context).size.height,
                                    //         fit:BoxFit.fill
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      child: ClipRRect(
                                        child: Image.network(
                                            userData['firstImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit:BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ClipRRect(
                                        child: Image.network(
                                            userData['secondImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit:BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ClipRRect(
                                        child: Image.network(
                                            userData['thirdImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit:BoxFit.fill
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                              // Container(
                              //   alignment: Alignment.topRight,
                              //   margin: EdgeInsets.only(right: 20, top: 20),
                              //   child: FavoriteButton(
                              //     isFavorite: false,
                              //     valueChanged: (_isFavorite) {
                              //       print('Is Favorite : $_isFavorite');
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10.0,),
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
                                      child: Text(userData["projectName"] , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.indigo)),
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
                                        child: Text(userData["price"] + "/sq ft", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                              text: userData["postedBy"],
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
                                              text: userData["city"],
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
                                        text: "Address : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text:userData["address"],
                                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 157,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 7,),
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
                                      child: Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.teal)),
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
                                        child: Text("", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                        text: "Detail : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: userData['detail'],
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
                                        text: "Price : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: userData["price"],
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
                                        text: "Area : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: userData["area"] +" SQ.FT",
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
                                        text: "Construction Status : ",
                                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: userData["status"],
                                              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 7,),
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
                                      child: Text("Project Detail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.teal)),
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
                                        child: Text("", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                      )
                                  )
                                ],
                              ),
                              SizedBox(height: 7,),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                        text: userData["description"],
                                        style: TextStyle(fontSize: 18, color: Colors.black,),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
