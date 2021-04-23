import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/firebase.dart';
import 'package:construction_application/screens/Login_with_phone.dart';
import 'package:construction_application/screens/broker_page.dart';
import 'package:construction_application/screens/builder_page.dart';
import 'package:construction_application/screens/forgotPassword.dart';
import 'package:construction_application/screens/homeScreenBuilderAndBroker.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:construction_application/screens/quick_register.dart';
//import 'package:construction_application/screens/quick_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import '../models/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, password;
  String smsCode;
  String verificationCode;
  String number;
  String myRole;
  String loginfail;
  String loginfail1;
  bool isAnimate = false;

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
                      Text("Login",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.indigo),),
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
                                  hintText: "Email",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.email_outlined),
                                errorText: loginfail != null ? 'User doesn\'t exist' : null,
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value)
                              {
                                if(value.isEmpty || !value.contains('@'))
                                {
                                  return 'invalid email';
                                }
                                return null;
                              },
                              onSaved: (input) => email = input,
                            ),
                          )
                      ),
                      SizedBox(height: 15.0,),
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
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                    icon: Icon(isAnimate == false ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
                                    onPressed: () {
                                      _handleAnimation();
                                    }
                                ),
                                errorText: loginfail1 != null ? 'password not match' : null,
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: isAnimate == false ? true : false,
                              validator: (value)
                              {
                                if(value.isEmpty || value.length<=5)
                                {
                                  return 'invalid password';
                                }
                                return null;
                              },
                              onSaved: (input) => password = input,

                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: 20.0,),
                          Spacer(),
                          InkWell(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotPassword()));
                            },
                          ),
                        ],
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
                          child: Text("Login",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                          onPressed:() async {
                            signIn();
                          },
                        ),
                      ),
                      SizedBox(height:20.0,),
                      // Container(
                      //   height:MediaQuery.of(context).size.height*0.07,
                      //   width: MediaQuery.of(context).size.width*0.6  ,
                      //   child: RaisedButton(
                      //     color: Colors.blue,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(35.0)
                      //     ),
                      //     child: Text("Quick Login",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                      //     onPressed:(){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneVerification()));
                      //       //Navigator.push(context, MaterialPageRoute(builder: (context)=>quickRegister()));
                      //     },
                      //   ),
                      // ), //QUICK_LOGIN
                      SizedBox(height: 20,),
                      GestureDetector(
                        child: Text("Don't have account? Sign up here",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 17.0),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp1()));
                        },
                      ),
                      // InkWell(
                      //   child: Text("Login With Mobile Number",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15.0),),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneVerification()));
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
  _handleAnimation() {
    setState(() {
      isAnimate = !isAnimate;
    });
  }
  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(user!=null){
          // User _auth=FirebaseAuth.instance.currentUser;
          // _auth.email;
          // User _auth=FirebaseAuth.instance.currentUser;
          // FirebaseFirestore.instance.collection('Users').doc(_auth.uid).set({'email':email});
          _fetch();
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString('email', email);
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }

        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }catch(e){
        print(e.hashCode);
        setState(() {
          if(e.hashCode==505284406){
            loginfail=e.toString();
          }
          else if(e.hashCode==185768934 || e.hashCode==287540269){
            loginfail1=e.toString();
          }

        });
      }
    }
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {myRole = ds.data()['role'];
      if(myRole == 'User') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      else if(myRole == 'Builder') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen1()));
      }
      else if(myRole == 'Broker') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen1()));
      }
      else {
        print("Invalid User Credentials");
      }
      }).catchError((e) {
        print(e);
      });
    }
  }


}