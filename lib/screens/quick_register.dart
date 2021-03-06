import 'package:construction_application/models/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class quickRegister extends StatefulWidget {
  @override
  _quickRegisterState createState() => _quickRegisterState();
}

class _quickRegisterState extends State<quickRegister> {
  List<String> lst1 = ['User', 'Builder', 'Broker'];
  int selectedIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController no = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
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
                    Text("Quick-Register", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                            controller: no,
                            decoration: InputDecoration(
                                hintText: "Mobile No.",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.call_outlined)
                            ),
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
                              onSaved: (val) {
                                // item.password = val;
                                _password=val;
                              }
                          ),
                        )
                    ),
                    //Password
                    // SizedBox(height: 15),
                    // Container(
                    //     height: MediaQuery.of(context).size.height * 0.068,
                    //     padding: EdgeInsets.only(left: 15),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //     child: Center(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(
                    //             hintText: "Confirm Password",
                    //             hintStyle: TextStyle(fontSize: 18),
                    //             focusedBorder: InputBorder.none,
                    //             enabledBorder: InputBorder.none,
                    //             prefixIcon: Icon(Icons.lock_outline)
                    //         ),
                    //         obscureText: true,
                    //         validator: (value)
                    //         {
                    //           if(value.isEmpty || value != password.text)
                    //           {
                    //             return 'invalid password';
                    //           }
                    //           return null;
                    //         },
                    //         // onSaved: (val) => item.password = val,
                    //       ),
                    //     )
                    // ),  //Confirm password
                    SizedBox(height: 33),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: RaisedButton(
                        onPressed:(){
                          signUp();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        color: Colors.blue,
                        child: Text("Quick-Register", style: TextStyle(fontSize: 22, color: Colors.white)),
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

  void signUp() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        User updateUser=FirebaseAuth.instance.currentUser;
        updateUser.updateProfile(displayName: name.text);
        userSetup(name.text, email.text, no.text,lst1[selectedIndex],"");
        if(updateUser!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }catch(e){
        print(e.message);
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







