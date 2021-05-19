import 'package:construction_application/screens/searchBypostedBy.dart';
import 'package:construction_application/screens/searchDemo.dart';
import 'package:construction_application/screens/searchByCategory.dart';
import 'package:construction_application/screens/searchByCity.dart';
import 'package:construction_application/screens/searchByLandmark.dart';
import 'package:construction_application/screens/searchBySellOrRent.dart';
import 'package:construction_application/screens/searchByStatus.dart';
import 'package:flutter/material.dart';

class searchProperty extends StatefulWidget {
  @override
  _searchPropertyState createState() => _searchPropertyState();
}

class _searchPropertyState extends State<searchProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // appBar: AppBar(
      //   title: Text("Search Page"),
      //   backgroundColor:Colors.indigo,
      // ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Search Page",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.indigo),),
              ),
            ),
            // GestureDetector(
            //   child: Container(
            //     margin: EdgeInsets.only(top:20,left: 30, right: 30),
            //     height: 50,
            //     width: MediaQuery
            //         .of(context)
            //         .size
            //         .width * 0.9,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       color: Colors.white,
            //     ),
            //     padding: EdgeInsets.only(left: 30, top: 15),
            //     child: Text("Search By City",
            //         style: TextStyle(color: Colors.grey, fontSize: 16)),
            //   ),
            //   onTap: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchFeed()));
            //   },
            // ),
            GestureDetector(
                child:Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 30, top: 15),
                  child: Text("Search By Category",
                      style: TextStyle(color: Colors.grey, fontSize: 16,)),
                ),
              onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByCategory()));
              },
            ),
            GestureDetector(
              child:Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text("Search By City",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByCity()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top:30,left: 30, right: 30),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text("Search By Landmark",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByLandmark()));
              },
            ),
            GestureDetector(
              child:Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text("Search By Sell or Rent",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchBySellOrRent()));
              },
            ),
            GestureDetector(
              child:Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text("Search By Status",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByStatus()));
              },
            ),
            GestureDetector(
              child:Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 30, top: 15),
                child: Text("Search By PostedBy",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByPostedBY()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
