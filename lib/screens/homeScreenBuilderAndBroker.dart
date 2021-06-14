import 'package:construction_application/screens/addPost.dart';
import 'package:construction_application/screens/admin.dart';
import 'package:construction_application/screens/builder_page.dart';
import 'package:construction_application/screens/changePassword.dart';
import 'package:construction_application/screens/emiCalculator.dart';
import 'package:construction_application/screens/favourite.dart';
import 'package:construction_application/screens/home_screen.dart';
import 'package:construction_application/screens/location.dart';
import 'package:construction_application/screens/login_screen.dart';
import 'package:construction_application/screens/myPost.dart';
import 'package:construction_application/screens/my_homePage.dart';
import 'package:construction_application/screens/newProject.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:construction_application/screens/postProjectBuilderBroker.dart';
import 'package:construction_application/screens/profile.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/searchByLandmark.dart';
import 'package:construction_application/screens/searchPage.dart';
import 'package:construction_application/screens/signup_screen.dart';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:construction_application/models/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebaseNotification.dart';
import 'locationDemo.dart';
import 'myNewProject.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  static Future openEmail({
    @required String toEmail,
    @required String subject,
    @required String body,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await _launchUrl(url);
  }

  static Future openPhoneCall({@required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';

    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
  openUrl() {
    String url = "https://anyror.gujarat.gov.in/";
    _launchUrl(url);
  }
  final List<Widget> _widgetOptions = <Widget>[
    MyPost(),
    MyNewProject(),
    addPost(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex =0 ;
  final _auth= FirebaseAuth.instance.currentUser;
  String myEmail;
  String myName;
  String myPhone;
  String myPhoto;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        // actions: [
        //   GestureDetector(
        //     child: Container(
        //       margin: EdgeInsets.symmetric(horizontal: 10.0),
        //       child: Row(
        //         children: [
        //           Icon(Icons.location_on_outlined),
        //           // IconButton(icon: Icon(Icons.location_on_outlined),
        //           //     onPressed: (){
        //           //   //signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
        //           //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewMap()));
        //           // }
        //           // ),
        //           Text("Mapview",style:TextStyle(color: Colors.white),)
        //         ],
        //       ),
        //     ),
        //     onTap: (){
        //         //signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
        //        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewMap()));
        //     },
        //   ),
        //
        // ],
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Icon(Icons.notifications),
                ],
              ),
            ),
            onTap: (){
              //signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirebaseMessagingDemo()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: (myPhoto!=null)?Image.network(
                            myPhoto,
                            fit: BoxFit.fill,
                          ):Image.asset(
                            "image/icon.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Container(
                      child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState!=ConnectionState.done){
                              return Text("Loading....");
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 45.0)),
                                Text("$myName",style: TextStyle(fontSize: 25.0),),
                                SizedBox(height: 5,),
                                Text("$myPhone",style: TextStyle(fontSize: 15.0),),
                                SizedBox(height: 5,),
                                Text("$myEmail",style: TextStyle(fontSize: 11.0),),
                                //Text("${_auth.phoneNumber}",style: TextStyle(fontSize: 15.0),)
                              ],
                            );
                          }
                      ),
                    )
                  ],
                )
            ),
            //),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.home_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Home")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>changePassword()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.add_box_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Post Property"),
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostProperty()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.add_box_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Post New Project"),
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>postNewProject()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.assignment_ind_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Switch to User")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.near_me_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Nearby Area Property")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>searchByLandmark()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.open_in_browser_outlined),
                  SizedBox(width: 25),
                  Text("Govt. Circulars")
                ],
              ),
              onTap: () {
                openUrl();
              },
            ),
            Divider(color: Colors.indigo,),
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0,)),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text("Contact Us",style: TextStyle(fontSize: 20.0,),),
                      SizedBox(height: 3.0,),
                      // Padding(padding: EdgeInsets.only(left: 10.0)),
                      // Text("9988776655",style: TextStyle(fontSize: 15.0,color: Colors.blue),)
                    ],
                  ),
                  SizedBox(width: 80.0,),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("image/call.png",)
                        ),
                      ),
                      height: 30.0,
                      width: 30.0,
                    ),
                    onTap: (){
                      openPhoneCall(phoneNumber: '(+91)9726696332');
                    },
                  ),
                  SizedBox(width: 20.0,),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("image/email.png",)
                        ),
                      ),
                      height: 50.0,
                      width: 50.0,
                    ),
                    onTap: (){
                      openEmail(toEmail: 'bhavinkgadhiya43@gmail.com', subject: '', body: '');
                    },
                  )
                ],
              ),
            ),
            Divider(color: Colors.indigo,),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.info_outline),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("About Us"),
                ],
              ),
              onTap: (){
                // FirebaseFirestore.instance.collection('propertyDetails').get().then((value){
                //   print(value.docs.length);
                // });
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.privacy_tip_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Privacy Policy")
                ],
              ),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.announcement_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Terms & Condition")
                ],
              ),
              onTap: (){
              },
            ),
            Divider(),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.logout),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Log-Out"),
                ],
              ),
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:(BuildContext context){
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        contentPadding: EdgeInsets.all(10),
                        actions: <Widget>[
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Text("Yes",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  )
                              ),
                              SizedBox(width: 20,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Text("No",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  )
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                );
              },
            )
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(_selectedIndex==0?Icons.home_filled:Icons.home_outlined, color: Colors.indigo),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==0?Icons.photo_library:Icons.photo_library_outlined, color: Colors.indigo),
            label: 'My Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==1?Icons.account_balance:Icons.account_balance_outlined, color: Colors.indigo),
            label: 'My Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==2?Icons.add_box_rounded:Icons.add_box_outlined, color: Colors.indigo),
            label: 'Add',
          ),

          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==3?Icons.account_circle:Icons.account_circle_outlined, color: Colors.indigo),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
  Future<bool> signOut() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('email');
    //prefs.remove('phoneNumber');
    await FirebaseAuth.instance.signOut();
  }
  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((value){
        myEmail=value.data()['email'];
        myName=value.data()['name'];
        myPhone=value.data()['mobileNumber'];
        myPhoto=value.data()['Image'];
        // print(myEmail);
        // print(myName);
        // print(myPhone);
      }).catchError((e){
        print(e);
      });
    }
  }
  Future<void> resetpassword(){
    User _auth = FirebaseAuth.instance.currentUser;
    _auth.sendEmailVerification();
  }
  Future<bool> post(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Enter Price"),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Post Property"),
                onPressed: ()  async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPropertyBuilderAndBroker()));
                },
              ),
              FlatButton(
                child: Text("Post New Project"),
                onPressed: ()  async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>postNewProject()));
                },
              )
            ],
          );
        }
    );
  }
}
