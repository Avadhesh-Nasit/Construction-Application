import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class userDetails extends StatefulWidget {
  final String value;

  const userDetails({Key key, this.value}) : super(key: key);

  @override
  _userDetailsState createState() => _userDetailsState(value);
}

class _userDetailsState extends State<userDetails> {
  final String value;

  _userDetailsState(this.value);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: RaisedButton(
            child: Text("Delete User",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            color: Colors.red,
            onPressed: (){
              delete();
            },
          ),
        ),
      ),
    );
  }
  Future <void> delete() async {
    await FirebaseFirestore.instance.collection('Users').doc(value).delete();
    Navigator.of(context).pop();
  }
}
