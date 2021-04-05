// import 'dart:convert';

// import 'package:device_info/device_info.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:package_info/package_info.dart';
// import 'http_exception.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class Authentication with ChangeNotifier
// {
//
//   Future<void> signUp(String email, String password) async
//   {
//     const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyACKY1foKZg7BmEKziGU7CnLX6eqzFPsnI';
//
//     try{
//       final response = await http.post(url, body: json.encode(
//           {
//             'email' : email,
//             'password' : password,
//             'returnSecureToken' : true,
//           }
//       ));
//       final responseData = json.decode(response.body);
// //      print(responseData);
//       if(responseData['error'] != null)
//       {
//         throw HttpException(responseData['error']['message']);
//       }
//
//     } catch (error)
//     {
//       throw error;
//     }
//
//   }
//
//   Future<void> logIn(String email, String password) async
//   {
//     const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyACKY1foKZg7BmEKziGU7CnLX6eqzFPsnI';
//
//     try{
//       final response = await http.post(url, body: json.encode(
//           {
//             'email' : email,
//             'password' : password,
//             'returnSecureToken' : true,
//           }
//       ));
//       final responseData = json.decode(response.body);
//       if(responseData['error'] != null)
//       {
//         throw HttpException(responseData['error']['message']);
//       }
// //      print(responseData);
//
//     } catch(error)
//     {
//       throw error;
//     }
//
//   }
// }
//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info/device_info.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:package_info/package_info.dart';

// class UserHelper {
//   static FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   static saveUser(User user) async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     int buildNumber = int.parse(packageInfo.buildNumber);
//
//     Map<String, dynamic> userData = {
//       "name": user.displayName,
//       "email": user.email,
//       "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
//       "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
//       "role": "user",
//       "build_number": buildNumber,
//     };
//     final userRef = _db.collection("users").doc(user.uid);
//     if ((await userRef.get()).exists) {
//       await userRef.update({
//         "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
//         "build_number": buildNumber,
//       });
//     } else {
//       await _db.collection("users").doc(user.uid).set(userData);
//     }
//     await _saveDevice(user);
//   }
//
//   static _saveDevice(User user) async {
//     DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
//     String deviceId;
//     Map<String, dynamic> deviceData;
//     if (Platform.isAndroid) {
//       final deviceInfo = await devicePlugin.androidInfo;
//       deviceId = deviceInfo.androidId;
//       deviceData = {
//         "os_version": deviceInfo.version.sdkInt.toString(),
//         "platform": 'android',
//         "model": deviceInfo.model,
//         "device": deviceInfo.device,
//       };
//     }
//     if (Platform.isIOS) {
//       final deviceInfo = await devicePlugin.iosInfo;
//       deviceId = deviceInfo.identifierForVendor;
//       deviceData = {
//         "os_version": deviceInfo.systemVersion,
//         "device": deviceInfo.name,
//         "model": deviceInfo.utsname.machine,
//         "platform": 'ios',
//       };
//     }
//     final nowMS = DateTime.now().toUtc().millisecondsSinceEpoch;
//     final deviceRef = _db
//         .collection("users")
//         .doc(user.uid)
//         .collection("devices")
//         .doc(deviceId);
//     if ((await deviceRef.get()).exists) {
//       await deviceRef.update({
//         "updated_at": nowMS,
//         "uninstalled": false,
//       });
//     } else {
//       await deviceRef.set({
//         "updated_at": nowMS,
//         "uninstalled": false,
//         "id": deviceId,
//         "created_at": nowMS,
//         "device_info": deviceData,
//       });
//     }
//   }
// }