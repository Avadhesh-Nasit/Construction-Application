import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/newProject.dart';
import 'package:construction_application/screens/postProjectBuilderBroker.dart';
import 'package:flutter/material.dart';

class addPost extends StatefulWidget {
  @override
  _addPostState createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      this.post();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,size: 30,),
              Text("POST",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
            ],
          ),
          onTap: (){
            post();
          },
        )
      ),
    );
  }
  Future<bool> post(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Post"),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              Row(
                children: [
                  RaisedButton(
                    child: Text("Post Property"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.indigo,
                    onPressed: ()  async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPropertyBuilderAndBroker()));
                    },
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    child: Text("Post New Project"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.indigo,
                    onPressed: ()  async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>postNewProject()));
                    },
                  )
                ],
              ),
            ],
          );
        }
    );
  }
}

