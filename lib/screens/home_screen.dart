import 'package:construction_application/screens/changePassword.dart';
import 'package:construction_application/screens/emiCalculator.dart';
import 'package:construction_application/screens/favourite.dart';
import 'package:construction_application/screens/firebaseNotification.dart';
import 'package:construction_application/screens/login_screen.dart';
import 'package:construction_application/screens/myPost.dart';
import 'package:construction_application/screens/my_homePage.dart';
import 'package:construction_application/screens/postProject.dart';
import 'package:construction_application/screens/profile.dart';
import 'package:construction_application/screens/propertyDetail.dart';
import 'package:construction_application/screens/searchPage.dart';
import 'package:construction_application/screens/searchProperty.dart';
import 'package:construction_application/screens/signup_screen.dart';
import 'package:construction_application/screens/soldProperty.dart';
import 'package:construction_application/screens/userSearch.dart';
import 'package:construction_application/screens/viewNewProject.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:construction_application/models/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'filter.dart';
import 'locationDemo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    myHomepage(),
    MyPost(),
    PostProperty(),
    userSearch(),
    ProfilePage()
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
        //   IconButton(icon: Icon(Icons.person),
        //       onPressed: (){
        //     signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
        //       }
        //   )
        // ],
          actions: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text("Mapview",style:TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              onTap: (){
                //signOut().whenComplete(()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (Route<dynamic>route) => false));
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewMap()));
              },
            ),
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           fit: BoxFit.fill,
                      //           image: AssetImage("image/icon.png")
                      //       )
                      //   ),
                      //   height: 80.0,
                      //   width: 80.0,
                      // ),
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
                                Text("$myName",style: TextStyle(fontSize: 22.0,color: Colors.indigo),),
                                SizedBox(height: 5,),
                                Text("$myPhone",style: TextStyle(fontSize: 15.0,color: Colors.teal),),
                                SizedBox(height: 5,),
                                Text("$myEmail",style: TextStyle(fontSize: 12.0,color: Colors.black),),
                                //Text("${_auth.phoneNumber}",style: TextStyle(fontSize: 15.0),)
                              ],
                            );
                          }
                        ),
                      )
                    ],
                  )
              ),

            ListTile(
              title:Row(
                children: [
                  Icon(Icons.home_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Home")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.favorite_border_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Favourite")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyFavoritePost()));
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
              title: Row(
                children: [
                  Icon(Icons.food_bank_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Sold property")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Sold_Property())),
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.home_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("New Project")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewNewProject()));

              },
            ),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.calculate_outlined),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("EMI Calculator")
                ],
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>emiCalculator()));
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
                  Text("About Us")
                ],
              ),
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
            ),
            Divider(color: Colors.indigo,),
            ListTile(
              title:Row(
                children: [
                  Icon(Icons.logout,),
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
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==0?Icons.home_filled:Icons.home_outlined, color: Colors.indigo),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==1?Icons.photo_library:Icons.photo_library_outlined, color: Colors.indigo),
            label: 'My Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==2?Icons.add_box_rounded:Icons.add_box_outlined, color: Colors.indigo),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.indigo),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==4?Icons.account_circle:Icons.account_circle_outlined, color: Colors.indigo),
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


}
