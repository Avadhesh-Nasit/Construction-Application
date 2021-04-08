import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class forgotPassword extends StatefulWidget {
  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
 String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: ListView(
          children: [
          Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Reset Password",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.indigo),),
              SizedBox(height: 100.0,),
              Container(
                  height: MediaQuery.of(context).size.height * 0.068,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: TextStyle(fontSize: 18),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.email_outlined)
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                        setState(() {
                          _email=value.trim();
                        });
                      },
                    ),
                  )
              ),
              SizedBox(height: 50.0,),
              Container(
                height:MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width*0.6  ,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)
                  ),
                  child: Text("Send",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                  onPressed:() async {
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      ],
    ),
    )
    );
  }
}
