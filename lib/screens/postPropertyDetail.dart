import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import 'my_homePage.dart';
class postPropertyDetail extends StatefulWidget {
  //final String doc;
  //const propertyDetail({Key key, this.doc}) : super(key: key);
  final String value;

  const postPropertyDetail({Key key, this.value}) : super(key: key);

  @override
  _postPropertyDetailState createState() => _postPropertyDetailState(value);
}

class _postPropertyDetailState extends State<postPropertyDetail> {
  final String value;
  var editprice;
  var editdesc;
  int selectedIndex=0;
  int selectedIndex1=0;


  _postPropertyDetailState(this.value);
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
                            height: 300,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                CarouselSlider(
                                    options: CarouselOptions(
                                      height: 280.0,
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
                                          child:Text(userData["price"] + "/sq ft", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),

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
                            height: 185,
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
                                Row(
                                  children: [
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
                                    Spacer(),
                                    GestureDetector(
                                      child: Container(
                                        width: 30.0,
                                        child: Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                      ),
                                      onTap: (){
                                        editPrice();
                                      },
                                    )
                                  ],
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
                                    child: Row(
                                      children: [
                                        RichText(
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
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          child: Container(
                                            width: 30.0,
                                            child: Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                          ),
                                          onTap: (){
                                            editStatus();
                                          },
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(height: 7),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 13),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: "Status : ",
                                              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                              children: [
                                                TextSpan(
                                                    text: userData["sellOrRent"],
                                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                                )
                                              ]
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          child: Container(
                                            width: 30.0,
                                            child: Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                          ),
                                          onTap: (){
                                            editStatus1();
                                          },
                                        )
                                      ],
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
                                          alignment: Alignment.topRight,
                                          height: 20,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width/2,
                                          child:  GestureDetector(
                                            child: Container(
                                              width: 30.0,
                                              child: Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                            ),
                                            onTap: (){
                                              editDescription();
                                            },
                                          )
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
                                SizedBox(height: 40.0,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        height: 40,
                                        child: RaisedButton(
                                          onPressed: () {
                                                delete();
                                          },
                                          color: Colors.red,
                                          child: Center(child: Text("Delete Post", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),

                                )
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
  void changeIndex_Status(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  Widget customRadio_1(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_Status(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  void changeIndex_Status1(int index){
    setState(() {
      selectedIndex1=index;
    });
  }
  Widget customRadio_2(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_Status1(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex1 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex1 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Future <void> delete() async {
    await FirebaseFirestore.instance.collection('propertyDetails').doc(value).delete();
  }
  Future<bool> editPrice(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Enter Price"),
            content: TextField(
              onChanged: (value){
                editprice=value;
              },
              keyboardType: TextInputType.number,
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Update"),
                onPressed: ()  async {
                  await FirebaseFirestore.instance.collection('propertyDetails').doc(value).update({
                    'price':editprice.toString(),
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  Future<bool> editDescription(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Enter Description"),
            content: TextField(
              onChanged: (value){
                editdesc=value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Update"),
                onPressed: ()  async {
                  await FirebaseFirestore.instance.collection('propertyDetails').doc(value).update({
                    'description':editdesc.toString(),
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  Future<bool> editStatus(){
    // return showDialog<void>(
    // context: context,
    // builder: (BuildContext context) {
    // int selectedIndex = 0;
    // return AlertDialog(
    // content: StatefulBuilder(
    // builder: (BuildContext context, StateSetter setState) {
    // return Column(
    // mainAxisSize: MainAxisSize.min,
    // children: List<Widget>.generate(2, (int index) {
    // return Radio<int>(
    // value: index,
    // groupValue: selectedIndex,
    // onChanged: (int value) {
    // setState(() => selectedIndex = value);
    // },
    // );
    // }),
    // );
    // },
    // ),
    // );
    // },
    // );
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          List<String> editstatus=["Completed","Under Construction"];
          return AlertDialog(
            title: Text("Enter Status"),
            content: Row(
                children: [
                  customRadio_1(editstatus[0], 0),
                  SizedBox(width: 20),
                  customRadio_1(editstatus[1], 1),
                ],
              ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Update"),
                onPressed: ()  async {
                  await FirebaseFirestore.instance.collection('propertyDetails').doc(value).update({
                    'status':editstatus[selectedIndex],
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],

          );

        }
    );
  }
  Future<bool> editStatus1(){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          List<String> editstatus1=["Sell","Rent"];
          return AlertDialog(
            title: Text("Enter Status"),
            content: Row(
              children: [
                customRadio_2(editstatus1[0], 0),
                SizedBox(width: 20),
                customRadio_2(editstatus1[1], 1),
              ],
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Update"),
                onPressed: ()  async {
                  await FirebaseFirestore.instance.collection('propertyDetails').doc(value).update({
                    'sellOrRent':editstatus1[selectedIndex],
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],

          );

        }
    );
  }
}

