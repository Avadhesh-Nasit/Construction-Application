import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_homePage.dart';
class projectDetail extends StatefulWidget {
  //final String doc;
  //const propertyDetail({Key key, this.doc}) : super(key: key);
  final String value;
  final String u2;

  const projectDetail({Key key, this.value,this.u2}) : super(key: key);

  @override
  _projectDetailState createState() => _projectDetailState(value);
}

class _projectDetailState extends State<projectDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showSnackBar(String value) {
    _scaffoldKey
        .currentState
        .showSnackBar(
        SnackBar(
          content: Text(value),
        )
    );
  }
  final String value;
  String view;
  String uName;
  String cate;
  String poB;
  String ci;
  String sta;
  String proN;
  String pri;
  String fiI;
  String poI;
  bool reportV;
  _projectDetailState(this.value);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String doc=doc_id;
    return StreamBuilder(
        stream:FirebaseFirestore.instance.collection("newProject").doc(value).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userData = snapshot.data;
          return Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   title: Text("New Launch Project"),
            //   elevation: 0.0,
            //   backgroundColor: Colors.indigo,
            // ),
            backgroundColor: Colors.blue.shade50,
            body:
            Container(
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
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView1(i1:userData['firstImage'])));
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            child: Hero(
                                              tag: 'imageHero1',
                                              child: Image.network(
                                                  userData['firstImage'],
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height,
                                                  fit:BoxFit.fill
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView2(i2:userData['secondImage'])));
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            child: Hero(
                                              tag: 'imageHero2',
                                              child: Image.network(
                                                  userData['secondImage'],
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height,
                                                  fit:BoxFit.fill
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView3(i3:userData['thirdImage'])));
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            child: Hero(
                                              tag: 'imageHero3',
                                              child: Image.network(
                                                  userData['thirdImage'],
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height,
                                                  fit:BoxFit.fill
                                              ),
                                            ),
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
                                          child: Text(userData["price"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                          text: "Detail/Maintenance : ",
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
                                                text: userData["area"],
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
                  ),
                  (widget.u2 == FirebaseAuth.instance.currentUser.uid)
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: RaisedButton(
                      color: Colors.red.shade500,
                      onPressed: () {
                        showSnackBar("Successfully labeled 'Sold'");
                        FirebaseFirestore.instance.collection('propertyDetails').doc(widget.value).updateData({
                          'markAsSold': 'Sold'
                        });
                        FirebaseFirestore.instance.collection('propertyDetails').doc(widget.value).get().then((value) => {
                          cate = value.get('category'),
                          poB = value.get('postedBy'),
                          proN = value.get('projectName'),
                          ci = value.get('city'),
                          pri = value.get('price'),
                          sta = value.get('status'),
                          fiI = value.get('firstImage'),
                          FirebaseFirestore.instance.collection('soldProperties').doc(widget.value).set({
                            'category': cate,
                            'postedBy': poB,
                            'projectName': proN,
                            'city': ci,
                            'price': pri,
                            'status': sta,
                            'firstImage': fiI
                          }),
                          Navigator.of(context).pop(),
                          FirebaseFirestore
                              .instance
                              .collection('propertyDetails')
                              .doc(widget.value)
                              .delete(),
                          FirebaseFirestore
                              .instance
                              .collection("propertyDetails")
                              .doc(widget.value)
                              .get()
                              .then((value) => {
                            reportV = value.get('report'),
                            if(reportV == true) {
                              FirebaseFirestore
                                  .instance
                                  .collection('reportProperty')
                                  .doc(widget.value)
                                  .delete()
                            }
                          })
                        });
                      },
                      child: Text("Mark as sold", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      showSnackBar("This property report Successfully");
                      FirebaseFirestore.instance.collection('propertyDetails').doc(widget.value).updateData({
                        'report': true,
                      });
                      FirebaseFirestore.instance.collection("propertyDetails").doc(widget.value).get().then((value) => {
                        poI = value.get('postedById'),
                        reportV = value.get('report'),
                        print(reportV),
                        FirebaseFirestore.instance.collection("reportProperty").doc(widget.value).set({
                          'propertyId': widget.value,
                          'postedUser': poI
                        })
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Center(
                        child: Text(
                          "Report Property",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
class ImageView1 extends StatelessWidget {
  final String i1;

  const ImageView1({Key key, this.i1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero1',
            child: Image.network(
              i1,
            ),
          ),
        ),
      ),
    );
  }
}
class ImageView2 extends StatelessWidget {
  final String i2;

  const ImageView2({Key key, this.i2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero2',
            child: Image.network(
              i2,
            ),
          ),
        ),
      ),
    );
  }
}
class ImageView3 extends StatelessWidget {
  final String i3;

  const ImageView3({Key key, this.i3}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero3',
            child: Image.network(
              i3,
            ),
          ),
        ),
      ),
    );
  }
}
