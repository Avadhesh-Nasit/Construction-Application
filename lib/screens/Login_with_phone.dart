// import 'package:flutter/material.dart';
// import 'otp.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String phoneNo;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Auth'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Form(
//             key: _formKey,
//             child: Column(children: [
//               Container(
//                 margin: EdgeInsets.only(top: 60),
//                 child: Center(
//                   child: Text(
//                     'Phone Authentication',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                   ),
//                 ),
//               ),
//               Container(
//                   height: MediaQuery.of(context).size.height * 0.068,
//                   padding: EdgeInsets.only(left: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           hintText: "Enter Number",
//                           hintStyle: TextStyle(fontSize: 18),
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           prefixIcon: Icon(Icons.email_outlined)
//                       ),
//                       keyboardType: TextInputType.phone,
//                       validator: (value)
//                       {
//                         if(value.length<10 || value.length>10)
//                         {
//                           return 'Invalid';
//                         }
//                         print(value.length);
//                         _formKey.currentState.save();
//                         return null;
//                       },
//                      onSaved: ((value){
//                        phoneNo='+91$value';
//                      }),
//                     ),
//                   )
//               ),
//             ]),
//           ),
//           Container(
//             margin: EdgeInsets.all(10),
//             width: double.infinity,
//             child: FlatButton(
//               color: Colors.blue,
//               onPressed: () {
//                 if(_formKey.currentState.validate()) {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => OTPScreen(phoneNo: phoneNo)));
//                 }
//                 },
//               child: Text(
//                 'Next',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'home_screen.dart';
//
// class MyAppPage extends StatefulWidget {
//   // MyAppPage({Key key, this.title}) : super(key: key);
//   // final String title;
//
//   @override
//   _MyAppPageState createState() => _MyAppPageState();
// }
//
// class _MyAppPageState extends State<MyAppPage> {
//   String phoneNo;
//   String smsOTP;
//   String verificationId;
//   String errorMessage = '';
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> verifyPhone() async {
//     final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
//       this.verificationId = verId;
//       smsOTPDialog(context).then((value) {
//         print('sign in');
//       });
//     };
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
//           codeAutoRetrievalTimeout: (String verId) {
//             //Starts the phone number verification process for the given phone number.
//             //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
//             this.verificationId = verId;
//           },
//           codeSent:
//           smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
//           timeout: const Duration(seconds: 20),
//           verificationCompleted: (AuthCredential phoneAuthCredential) {
//             print(phoneAuthCredential);
//           },
//           verificationFailed: (FirebaseAuthException exceptio) {
//             print('${exceptio.message}');
//           });
//     } catch (e) {
//       handleError(e);
//     }
//   }
//
//   Future<bool> smsOTPDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: Text('Enter SMS Code'),
//             content: Container(
//               height: 85,
//               child: Column(children: [
//                 TextField(
//                   onChanged: (value) {
//                     this.smsOTP = value;
//                   },
//                 ),
//                 (errorMessage != ''
//                     ? Text(
//                   errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 )
//                     : Container())
//               ]),
//             ),
//             contentPadding: EdgeInsets.all(10),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Done'),
//                 onPressed: () {
//                   var user=_auth.currentUser;
//                     if (user != null) {
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
//                     } else {
//                       signIn();
//                     }
//
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//   signIn() async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.getCredential(
//         verificationId: verificationId,
//         smsCode: smsOTP,
//       );
//       final User user = (await _auth.signInWithCredential(credential)) as User;
//       final User currentUser = await _auth.currentUser;
//       assert(user.uid == currentUser.uid);
//       Navigator.of(context).pop();
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
//     } catch (e) {
//       handleError(e);
//     }
//   }
//
//   handleError(PlatformException error) {
//     print(error);
//     switch (error.code) {
//       case 'ERROR_INVALID_VERIFICATION_CODE':
//         FocusScope.of(context).requestFocus(new FocusNode());
//         setState(() {
//           errorMessage = 'Invalid Code';
//         });
//         Navigator.of(context).pop();
//         smsOTPDialog(context).then((value) {
//           print('sign in');
//         });
//         break;
//       default:
//         setState(() {
//           errorMessage = error.message;
//         });
//
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Phone"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: TextField(
//                 decoration: InputDecoration(
//                     hintText: 'Enter Phone Number Eg. +910000000000'),
//                 onChanged: (value) {
//                   this.phoneNo = value;
//                 },
//               ),
//             ),
//             (errorMessage != ''
//                 ? Text(
//               errorMessage,
//               style: TextStyle(color: Colors.red),
//             )
//                 : Container()),
//             SizedBox(
//               height: 10,
//             ),
//             RaisedButton(
//               onPressed: () {
//                 verifyPhone();
//               },
//               child: Text('Verify'),
//               textColor: Colors.white,
//               elevation: 7,
//               color: Colors.blue,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String smsCode;
  String verificationCode;
  String number;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      Text("Mobile Verification",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.indigo),),
                      SizedBox(height: 50.0,),
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
                                  hintText: "Enter Phone Number",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.phone_outlined)
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (value){
                                number=value;
                              },
                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height:MediaQuery.of(context).size.height*0.07,
                        width: MediaQuery.of(context).size.width*0.4  ,
                        child: RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)
                          ),
                          child: Text("Send OTP",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                          onPressed:(){
                            _submit();
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
  Future<void> _submit() async{

  final PhoneVerificationCompleted verificationSuccess =(AuthCredential credential){
    setState(() {
      print("Verification");
      print(credential);
    });
  };

  final PhoneVerificationFailed phoneVerificationFailed =(FirebaseAuthException exception){
    print("${exception.message}");
  };
  final PhoneCodeSent phoneCodeSent =(String verId,[int forceCodeResend]){
    this.verificationCode = verId;
    smsCodeDialog(context).then((value)=>print("Signed In"));
  };
  final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout=(String verId){
    this.verificationCode =verId;
  };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.number,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );
  }
  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Enter Code"),
            content: TextField(
              onChanged: (value){
                smsCode=value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                  child: Text("Verify"),
                onPressed: ()  async {
                    var user=FirebaseAuth.instance.currentUser;
                    if(user!=null){
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        prefs.setString('phoneNumber',number);
                      // User _auth=FirebaseAuth.instance.currentUser;
                      // FirebaseFirestore.instance.collection('Users').doc(_auth.uid).set({'phoneNumber':number});
                    }
                    else{
                      Navigator.of(context).pop();
                      signIn();
                    }
                },
              )
            ],
          );
        }
        );
  }
  signIn(){
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId:verificationCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)
        .then((value) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>HomeScreen()),
    )).catchError((e)=>print(e));
  }
}
