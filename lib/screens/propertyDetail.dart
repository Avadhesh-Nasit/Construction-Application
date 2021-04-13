import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
class propertyDetail extends StatefulWidget {
  @override
  _propertyDetailState createState() => _propertyDetailState();
}

class _propertyDetailState extends State<propertyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.indigo,
      // ),
      backgroundColor: Colors.grey.shade200,
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
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlay: true,
                                //aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                //enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                                //viewportFraction: 0.8,
                              ),
                              items: [
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'image/home.jpg',
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'image/home.jpg',
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'image/home.jpg',
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'image/home.jpg',
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(right: 20, top: 20),
                            child: FavoriteButton(
                              isFavorite: false,
                              valueChanged: (_isFavorite) {
                                print('Is Favorite : $_isFavorite');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
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
                                  child: Text("Silver-Villa", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                                    child: Text("4500", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                    text: "Posted by : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        // text: "Builder",
                                          text: "Broker",
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
                                          text: "Surat",
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
                                          text: "Nana Varachha,Surat",
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
                                  child: Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                    text: "Availability : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: "2 BHK",
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
                                          text: "Rs. 10,00,000/-",
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
                                          text: "4500 SQ.FT",
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
                                          text: "Under Construction",
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
                                  child: Text("Project Detail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                    text: "A flat is a set of rooms for living in, usually on one floor and part of a larger building. A flat usually includes a kitchen and bathroom.",
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
}
