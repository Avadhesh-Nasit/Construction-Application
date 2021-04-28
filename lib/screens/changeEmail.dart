import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class changeEmail extends StatefulWidget {
  @override
  _changeEmailState createState() => _changeEmailState();
}

class _changeEmailState extends State<changeEmail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _newemailController = TextEditingController();
  var _passwordController = TextEditingController();
  bool checkCurrentEmailValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue .shade50,
      body: Center(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Change Email", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      SizedBox(height: 70),
                      // Container(
                      //     height: MediaQuery.of(context).size.height * 0.068,
                      //     padding: EdgeInsets.only(left: 15),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: Center(
                      //       child: TextFormField(
                      //         controller: _emailController,
                      //         decoration: InputDecoration(
                      //           hintText: "Old Email",
                      //           hintStyle: TextStyle(fontSize: 18),
                      //           focusedBorder: InputBorder.none,
                      //           enabledBorder: InputBorder.none,
                      //           prefixIcon: Icon(Icons.lock_outlined),
                      //           errorText: checkCurrentEmailValid
                      //               ? null
                      //               : "Please double check your current email",
                      //         ),
                      //         keyboardType: TextInputType.text,
                      //         // onSaved: (val) => item.name = val,
                      //       ),
                      //     )
                      // ),
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
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                return checkCurrentEmailValid
                                    ? null
                                    : "Please validate your entered password";
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outlined)
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          )
                      ),  //Mobile No.//Name
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
                              controller: _newemailController,
                              decoration: InputDecoration(
                                  hintText: "Enter new Email",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outlined)
                              ),
                              keyboardType: TextInputType.text,

                            ),
                          )
                      ),  //Email
                      SizedBox(height: 70),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: RaisedButton(
                          onPressed:() async {
                            final firebaseUser = await FirebaseAuth.instance.currentUser;
                            checkCurrentEmailValid =
                            await validateEmail(
                                _passwordController.text);
                            setState(() {
                              if(formKey.currentState.validate() && checkCurrentEmailValid){
                                firebaseUser.updateEmail(_newemailController.text);
                                Navigator.pop(context);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          color: Colors.blue,
                          child: Text("Change Password", style: TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> validateEmail(String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.getCredential(email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).update({
        'email': _newemailController.text,

      });
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
