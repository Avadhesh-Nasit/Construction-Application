import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';
import '../main.dart';
import '../models/authentication.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  List<String> lst1 = ['User', 'Builder', 'Broker'];
  int selectedIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;
  String em = "";
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController no = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String em1;
  List myData1 = [];
  String ok;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child:ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10, left: 10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Register", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo)),
                    SizedBox(height: 25),
                    Text("Register As"),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadio(lst1[0], 0),
                        SizedBox(width: 10,),
                        customRadio(lst1[1], 1),
                        SizedBox(width: 10,),
                        customRadio(lst1[2], 2),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.account_circle_outlined)
                            ),
                            keyboardType: TextInputType.text,
                            // onSaved: (val) => item.name = val,
                          ),
                        )
                    ),  //Name
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  em1 = val;
                                });
                              },
                              controller: email,
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.email_outlined)
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // validator: (value)
                            // {
                            //   value == ok
                            //       ? "user already exist"
                            //   // ignore: unrelated_type_equality_checks
                            //       : value == "" ? "please enter email" : null;
                            //   if(value.isEmpty || !value.contains('@'))
                            //   {
                            //     return 'invalid email';
                            //   }
                            //   return null;
                            // },
                              validator: (val) => val == ok
                                  ? "user already exist"
                              // ignore: unrelated_type_equality_checks
                                  : val == "" ? "please enter email" : null,
                            onSaved: (val) {
                              // item.email = val;
                              _email=val;
                            }
                          ),
                        )
                    ),  //Email
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            maxLength: 10,
                            controller: no,
                            decoration: InputDecoration(
                                hintText: "Mobile No.",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.call_outlined)
                            ),
                            validator: (value)
                            {
                              if(value.isEmpty || value.length!=10)
                              {
                                return 'Invalid Phone Number ';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            // onSaved: (val) => item.no = val,
                          ),
                        )
                    ),  //Mobile No.
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                              controller: password,
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.lock_outline)
                            ),
                            obscureText: true,
                            validator: (value)
                            {
                              if(value.isEmpty || value.length<=5)
                              {
                                return 'invalid password';
                              }
                              return null;
                            },
                              // validator: (value) {
                              //   return (password.text == value || value.isEmpty || value.length<=5)
                              //       ? null
                              //       : "Please validate your entered password";
                              // },
                            onSaved: (val) {
                              // item.password = val;
                              _password=val;
                            }
                          ),
                        )
                    ),  //Password
                    SizedBox(height: 15),
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
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.lock_outline)
                            ),
                            obscureText: true,
                            validator: (value)
                            {
                              if(value.isEmpty || value != password.text)
                              {
                                return 'invalid password';
                              }
                              return null;
                            },
                            // validator: (value){
                            //   return(value!=password.text || value.isEmpty)
                            //       ?null
                            //       : "Please check your current password";
                            // },
                            // onSaved: (val) => item.password = val,
                          ),
                        )
                    ),  //Confirm password
                    SizedBox(height: 33),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: RaisedButton(
                        onPressed:(){
                          // handleSubmit();
                          validate();
                            signUp();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        color: Colors.blue,
                        child: Text("Register", style: TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void validate() async {
    await FirebaseFirestore.instance.collection('Users').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((element) {
        myData1.add(element.data()['email']);
      });
    });
    for(int i=0; i<myData1.length; i++) {
      if(myData1[i] == em1) {
        setState(() {
          ok = myData1[i];
        });
      }
    }
    print(myData1);
    print(ok);
    //print(myData);
    myData1.removeRange(0, myData1.length);
    print(myData1);
  }

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  void signUp() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        User updateUser=FirebaseAuth.instance.currentUser;
        updateUser.updateProfile(displayName: name.text);
        userSetup(name.text, email.text, no.text,lst1[selectedIndex], "");
        if(updateUser!=null){
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString('email', _email);
          // User _auth=FirebaseAuth.instance.currentUser;
          // FirebaseFirestore.instance.collection('Users').doc(_auth.uid).set({'email':email});
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }catch(e){
        print(e.message);
      }
      if(em1 != ok) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    }
  }
  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget customRadio(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey),),
    );
  }
}
