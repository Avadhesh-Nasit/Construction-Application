import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class favourite extends StatefulWidget {
  @override
  _favouriteState createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Favourite Page",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
    );
  }
}
