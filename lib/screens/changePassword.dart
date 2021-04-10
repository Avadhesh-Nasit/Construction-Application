import 'package:construction_application/screens/postProject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();
  bool checkCurrentPasswordValid = true;
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
                      Text("Change Password", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      SizedBox(height: 70),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.068,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: "Old Password",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outlined),
                                errorText: checkCurrentPasswordValid
                                    ? null
                                    : "Please double check your current password",
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
                              controller: _newPasswordController,
                                decoration: InputDecoration(
                                    hintText: "New Password",
                                    hintStyle: TextStyle(fontSize: 18),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock_outlined)
                                ),
                                keyboardType: TextInputType.text,

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
                              obscureText: true,
                              controller: _repeatPasswordController,
                              validator: (value) {
                                return _newPasswordController.text == value
                                    ? null
                                    : "Please validate your entered password";
                              },
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outlined)
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          )
                      ),  //Mobile No.
                      SizedBox(height: 70),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: RaisedButton(
                          onPressed:() async {
                            final firebaseUser = await FirebaseAuth.instance.currentUser;
                            checkCurrentPasswordValid =
                            await validatePassword(
                                _passwordController.text);
                            setState(() {
                              if(formKey.currentState.validate() && checkCurrentPasswordValid){
                                firebaseUser.updatePassword(_newPasswordController.text);
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
  Future<bool> validatePassword(String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.getCredential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
