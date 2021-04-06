import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/builder_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'models/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login App',
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//       ),
//       home: Login(),
//       routes: {
//         '/login': (context) => Login(),
//         '/signup': (context) => MyApp1(),
//         '/home': (context) => HomeScreen()
//       },
//     );
//   }
// }

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email =prefs.getString('email');
  runApp(MaterialApp(home:email==null?Login():HomeScreen(),));
}

// class Main extends StatefulWidget {
//   @override
//   _MainState createState() => _MainState();
// }
//
// class _MainState extends State<Main> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if(snapshot.hasData && snapshot.data != null) {
//             //UserHelper.saveUser(snapshot.data);
//             return StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data.uid).snapshots() ,
//               builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
//                 if(snapshot.hasData && snapshot.data != null) {
//                   final userDoc = snapshot.data;
//                   final user = userDoc.data();
//                   if(user['role'] == 'Builder') {
//                     return builderPage();
//                   }else{
//                     return HomeScreen();
//                   }
//                 }else{
//                   return Material(
//                     child: Center(child: CircularProgressIndicator(),),
//                   );
//                 }
//               },
//             );
//           }
//           return Login();
//         }
//     );
//   }
// }
class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myapp1(),
            routes: {
        '/login': (context) => Login(),
        '/signup': (context) => MyApp1(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}
class myapp1 extends StatefulWidget {
  @override
  _myapp1State createState() => _myapp1State();
}

class _myapp1State extends State<myapp1> {
  @override
  void initState() {
    final keep=FirebaseAuth.instance.currentUser;
    if(keep==null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
    }
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Wel-Come"),),
    );
  }
}



