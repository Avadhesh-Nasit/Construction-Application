import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/models/firebase.dart';
import 'package:construction_application/screens/builder_page.dart';
import 'package:construction_application/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';

import 'addToMap.dart';
import 'addToMapBuilder.dart';
import 'homeScreenBuilderAndBroker.dart';

class ResidentialFilterEntry1 {
  const ResidentialFilterEntry1(this.name1);
  final String name1;
}

class CommercialFilterEntry1 {
  const CommercialFilterEntry1(this.cname1);
  final String cname1;
}
class PostPropertyBuilderAndBroker extends StatefulWidget {
  @override
  _PostPropertyBuilderAndBrokerState createState() => _PostPropertyBuilderAndBrokerState();
}

class _PostPropertyBuilderAndBrokerState extends State<PostPropertyBuilderAndBroker> {
  DocumentReference propertyRes = FirebaseFirestore.instance.collection('propertyDetails').doc();
  DocumentReference propertyCom = FirebaseFirestore.instance.collection('propertyDetails').doc();

  Future<void> postProperty(String category,
      String postBy,
      String sr_radio,
      String pro_type,
      String projectName,
      String address,
      String landmark,
      String city,
      String state,
      String pro_detail,
      String area,
      String price,
      String description,
      String con_status,
      String firstImage,
      String secondImage,
      String thirdImage,
      String userId,
      int view,
      String mark,
      bool report
      ) async {

    // final query = location;
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // var first = addresses.first;
    //var firebaseUser = await FirebaseAuth.instance.currentUser;
    //FirebaseAuth auth = FirebaseAuth.instance;
    //String uid = auth.currentUser.uid.toString();
    propertyRes.set({
      'category': category,
      'postedBy': postBy,
      'sellOrRent': sr_radio,
      'propertyType': pro_type,
      'projectName': projectName,
      'address': address,
      'landmark': landmark,
      'city': city,
      'state': state,
      'detail': pro_detail,
      'area': area,
      'price': price,
      'description': description,
      'status': con_status,
      'firstImage': firstImage,
      'secondImage': secondImage,
      'thirdImage': thirdImage,
      'postedById':userId,
      'propertyId':propertyRes.documentID,
      'view':view,
      'markAsSold':mark,
      'report':report
    });
    // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
    return;
  }

  Future<void> postCommProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String area, String price, String description, String con_status,String firstImage,String secondImage,String thirdImage,String detail,String userId,int view,String mark,bool report) async {
    //var firebaseUser = await FirebaseAuth.instance.currentUser;
    //FirebaseAuth auth = FirebaseAuth.instance;
    //String uid = auth.currentUser.uid.toString();
    // final query = location;
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // var first = addresses.first;
    propertyCom.set({
      'category': category,
      'postedBy': postBy,
      'sellOrRent': sr_radio,
      'propertyType': pro_type,
      'projectName': projectName,
      'address': address,
      'landmark': landmark,
      'city': city,
      'state': state,
      'area': area,
      'price': price,
      'description': description,
      'status': con_status,
      'firstImage': firstImage,
      'secondImage': secondImage,
      'thirdImage': thirdImage,
      'detail':detail,
      'postedById': userId,
      'propertyId':propertyCom.documentID,
      'view':view,
      'markAsSold':mark,
      'report':report
    });
    // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
    return;
  }

  final List<ResidentialFilterEntry1> residential1_cast = <ResidentialFilterEntry1>[
    const ResidentialFilterEntry1('Apartment'),
    const ResidentialFilterEntry1('Villa/House'),
    const ResidentialFilterEntry1('Row House'),
    const ResidentialFilterEntry1('Farm House'),
    const ResidentialFilterEntry1('Plot'),
    const ResidentialFilterEntry1('Pent House'),
    const ResidentialFilterEntry1('Others'),
  ];
  List<String> _filters1 = <String>[];

  Iterable<Widget> get residentialWidgets sync* {
    for (final ResidentialFilterEntry1 residential in residential1_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(residential.name1),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: _filters1.contains(residential.name1),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  _filters1.add(residential.name1);
                } else {
                  _filters1.removeWhere((String name) {
                    return name == residential.name1;
                  });
                }
                print('${_filters1.join(',  ')}');
              });
            },
          ),
        ),
      );
    }
  }

  final List<CommercialFilterEntry1> commercial1_cast = <CommercialFilterEntry1>[
    const CommercialFilterEntry1('Office Space'),
    const CommercialFilterEntry1('Shop'),
    const CommercialFilterEntry1('Ware House'),
    const CommercialFilterEntry1('Commercial Land'),
    const CommercialFilterEntry1('Hotel'),
    const CommercialFilterEntry1('Showroom'),
    const CommercialFilterEntry1('Others'),
  ];
  // ignore: non_constant_identifier_names
  List<String> commercial1_filters = <String>[];

  Iterable<Widget> get commercialWidgets sync* {
    for (final CommercialFilterEntry1 commercial1 in commercial1_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(commercial1.cname1),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: commercial1_filters.contains(commercial1.cname1),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  commercial1_filters.add(commercial1.cname1);
                } else {
                  commercial1_filters.removeWhere((String name) {
                    return name == commercial1.cname1;
                  });
                }
                print('${commercial1_filters.join(',  ')}');
              });
            },
          ),
        ),
      );
    }
  }

  // File _imageFile;
  // File _imageFile1;
  // File _imageFile3;
  // final picker = ImagePicker();
  //
  // _openCamera() async {
  //   // var picture = await ImagePicker.pickImage(source: ImageSource.camera);
  //   // this.setState(() {
  //   //   imageFile = picture;
  //   // });
  //   // Navigator.of(context).pop();
  // }
  //
  // _openGallery() async {
  //   // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   // this.setState(() {
  //   //   imageFile = picture;
  //   // });
  //   // Navigator.pop(context);
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _imageFile = File(pickedFile.path);
  //   });
  //   //uploadImageToFirebase(context);
  //   Navigator.of(context).pop();
  // }
  //
  // _openGallery1() async {
  //   // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   // this.setState(() {
  //   //   imageFile = picture;
  //   // });
  //   // Navigator.pop(context);
  //   final pickedFile1 = await picker.getImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _imageFile1 = File(pickedFile1.path);
  //   });
  //   //uploadImageToFirebase1(context);
  //   Navigator.of(context).pop();
  // }
  //
  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = _imageFile.path;
  //   StorageReference firebaseStorageRef =
  //   FirebaseStorage.instance.ref().child('property_images/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value){
  //           postProperty(
  //             'Residential',
  //             '${owner_builder_broker[selectedIndex]}',
  //             '${sell_and_rent[selectedIndex1]}',
  //             '$_filters1',
  //             '${project_name_controller_r.text}',
  //             '${address_controller_r.text}, ${landmark_controller_r.text}, ${city_controller_r.text},  ${state_controller_r.text}',
  //             '${landmark_controller_r.text}',
  //             '${city_controller_r.text}',
  //             '${state_controller_r.text}',
  //             '${bhk[selectedIndex2]}',
  //             '${area_controller_r.text}',
  //             '${price_controller_r.text}',
  //             '${project_description_controller_r.text}',
  //             '${construction_status[selectedIndex3]}',
  //             value
  //           );
  //         },
  //   );
  // }
  //
  // Future uploadImageToFirebase1(BuildContext context) async {
  //   String fileName = _imageFile1.path;
  //   StorageReference firebaseStorageRef =
  //   FirebaseStorage.instance.ref().child('property_images/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile1);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value){
  //           postCommProperty(
  //               'Commercial',
  //               '${owner_builder_broker[selectedIndex]}',
  //               '${sell_and_rent_1c[selectedIndex1c]}',
  //               '$commercial1_filters',
  //               '${project_name_controller_c.text}',
  //               '${address_controller_c.text}, ${landmark_controller_c.text}, ${city_controller_c.text}, ${state_controller_c.text}',
  //               '${landmark_controller_c.text}',
  //               '${city_controller_c.text}',
  //               '${state_controller_c.text}',
  //               '${area_controller_c.text}',
  //               '${price_controller_c.text}',
  //               '${project_description_controller_c.text}',
  //               '${construction_status_4c[selectedIndex4c]}',
  //               value,
  //
  //           );
  //         },
  //   );
  // }
  //

  List States = [
    "Select State", "Andhra Pradesh", "Arunachal Pradesh", "Assam", "  Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh",
    "Jharkhand", " Karnataka", "  Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha",
    "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", " West Bengal"
  ];
  int _value2=0;

  int userView=0;
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _retrievedImageUrl;

  Future getImage1() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image1 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage2() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image2 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage3() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image3 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage4() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image4 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage5() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image5 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage6() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image6 = image;
      });
    } catch (e) {
      print(e);
    }
  }

  Future uploadMultipleImages1() async {
    List<File> _imageList = List();
    List<String> _imageUrls = List();

    _imageList.add(_image1);
    _imageList.add(_image2);
    _imageList.add(_image3);

    try {
      for (int i = 0; i < _imageList.length; i++) {

        // if(_imageList[i] == null) {
        //
        // }
        String fileName = _imageList[i].path;
        final StorageReference storageReference = FirebaseStorage().ref().child("multiple2/$fileName");

        final StorageUploadTask uploadTask = storageReference.putFile(_imageList[i]);

        final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
          // You can use this to notify yourself or your user in any kind of way.
          // For example: you could use the uploadTask.events stream in a StreamBuilder instead
          // to show your user what the current status is. In that case, you would not need to cancel any
          // subscription as StreamBuilder handles this automatically.

          // Here, every StorageTaskEvent concerning the upload is printed to the logs.
          print('EVENT ${event.type}');
        });

        // Cancel your subscription when done.
        await uploadTask.onComplete;
        streamSubscription.cancel();

        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl); //all all the urls to the list
      }
      //upload the list of imageUrls to firebase as an array
      // await _firestore.collection("users").document().setData({
      //   "arrayOfImages": _imageUrls,
      // });8
      postProperty(
          'Residential',
          '${owner_builder_broker[selectedIndex]}',
          '${sell_and_rent[selectedIndex1]}',
          '${propertyType[propertyTypeSelect]}',
          '${project_name_controller_r.text}',
          '${address_controller_r.text}, ${landmark_controller_r.text}, ${city_controller_r.text},  ${state_controller_r.text}',
          '${landmark_controller_r.text}',
          '${city_controller_r.text}',
          '${States[_value2]}',
          '${bhk[selectedIndex2]}',
          '${area_controller_r.text} ${Items1[_value1]}',
          '${price_controller_r.text}/${Items1[_value1]}',
          '${project_description_controller_r.text}',
          '${construction_status[selectedIndex3]}',
          '${_imageUrls[0]}',
          '${_imageUrls[1]}',
          '${_imageUrls[2]}',
          '${FirebaseAuth.instance.currentUser.uid}',
          userView,
          'Available',
          false
      );

      //postProperty(category, postBy, sr_radio, pro_type, projectName, address, landmark, city, state, pro_detail, area, price, description, con_status, url_link)
    } catch (e) {
      print(e);
    }
  }
  Future uploadMultipleImages2() async {
    List<File> _imageList = List();
    List<String> _imageUrls = List();

    _imageList.add(_image4);
    _imageList.add(_image5);
    _imageList.add(_image6);

    try {
      for (int i = 0; i < _imageList.length; i++) {

        // if(_imageList[i] == null) {
        //
        // }
        String fileName = _imageList[i].path;
        final StorageReference storageReference = FirebaseStorage().ref().child("multiple2/$fileName");

        final StorageUploadTask uploadTask = storageReference.putFile(_imageList[i]);

        final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
          // You can use this to notify yourself or your user in any kind of way.
          // For example: you could use the uploadTask.events stream in a StreamBuilder instead
          // to show your user what the current status is. In that case, you would not need to cancel any
          // subscription as StreamBuilder handles this automatically.

          // Here, every StorageTaskEvent concerning the upload is printed to the logs.
          print('EVENT ${event.type}');
        });

        // Cancel your subscription when done.
        await uploadTask.onComplete;
        streamSubscription.cancel();

        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl); //all all the urls to the list
      }
      //upload the list of imageUrls to firebase as an array
      await _firestore.collection("users").document().setData({
        "arrayOfImages": _imageUrls,
      });
      postCommProperty(
          'Commercial',
          '${owner_builder_broker[selectedIndex]}',
          '${sell_and_rent_1c[selectedIndex1c]}',
          '${propertyTypeCom[propertyTypeSelectCom]}',
          '${project_name_controller_c.text}',
          '${address_controller_c.text}, ${landmark_controller_c.text}, ${city_controller_c.text}, ${state_controller_c.text}',
          '${landmark_controller_c.text}',
          '${city_controller_c.text}',
          '${States[_value2]}',
          '${area_controller_c.text} ${Items1[_value1]}',
          '${price_controller_c.text}/${Items1[_value1]}',
          '${project_description_controller_c.text}',
          '${construction_status_4c[selectedIndex4c]}',
          '${_imageUrls[0]}',
          '${_imageUrls[1]}',
          '${_imageUrls[2]}',
          '${detail_controller.text}',
          '${FirebaseAuth.instance.currentUser.uid}',
          userView,
          'Available',
          false

      );
      //postProperty(category, postBy, sr_radio, pro_type, projectName, address, landmark, city, state, pro_detail, area, price, description, con_status, url_link)
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _optionsDialogBox1(BuildContext context) {
  //   return showDialog(context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Make a Choice"),
  //           content: new SingleChildScrollView(
  //             child: new ListBody(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   child: new Text('Take a picture'),
  //                   onTap: () {
  //                     _openCamera();
  //                   },
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                 ),
  //                 GestureDetector(
  //                   child: new Text('Select from gallery'),
  //                   onTap: () {
  //                     _openGallery1();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // Future<void> _optionsDialogBox(BuildContext context) {
  //   return showDialog(context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Make a Choice"),
  //           content: new SingleChildScrollView(
  //             child: new ListBody(
  //               children: <Widget>[
  //                 GestureDetector(
  //                   child: new Text('Take a picture'),
  //                   onTap: () {
  //                     _openCamera();
  //                   },
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                 ),
  //                 GestureDetector(
  //                   child: new Text('Select from gallery'),
  //                   onTap: () {
  //                     _openGallery();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  List<String> sell_and_rent=["Sell","Rent"];
  List<String> sell_and_rent_1c=["Sell","Rent"];
  List<String> owner_builder_broker=["Owner","Builder","Broker"];
  List<String> bhk=["1BHK","2BHK","3BHK","4BHK"];
  List<String> construction_status=["Completed","Under Construction"];
  List<String> construction_status_4c=["Completed","Under Construction"];
  int selectedIndex=0;
  int selectedIndex1=0;
  int selectedIndex1c=0;
  int selectedIndex2=0;
  int selectedIndex3=0;
  int selectedIndex4c=0;
  TextEditingController project_name_controller_r = TextEditingController();
  TextEditingController address_controller_r = TextEditingController();
  TextEditingController landmark_controller_r = TextEditingController();
  TextEditingController state_controller_r = TextEditingController();
  TextEditingController city_controller_r = TextEditingController();
  TextEditingController area_controller_r = TextEditingController();
  TextEditingController price_controller_r = TextEditingController();
  TextEditingController project_description_controller_r = TextEditingController();
  TextEditingController project_name_controller_c = TextEditingController();
  TextEditingController address_controller_c = TextEditingController();
  TextEditingController landmark_controller_c = TextEditingController();
  TextEditingController state_controller_c = TextEditingController();
  TextEditingController city_controller_c = TextEditingController();
  TextEditingController area_controller_c = TextEditingController();
  TextEditingController price_controller_c = TextEditingController();
  TextEditingController project_description_controller_c = TextEditingController();
  TextEditingController detail_controller = TextEditingController();
  TextEditingController addToMap = TextEditingController();
  String inputaddr='';
  int _value1=0;
  List Items1 = [
    "Sq. Meter", "Are", "Hectare", "Sq. Feet", "Sq. Kilometer",
    "Sq. Yard", "Sq. Mile", "Sq. Inch", "Guntha", "Vigha(23.5)",
    "Vigha(16)"
  ];
  int propertyTypeSelect = 0;
  int propertyTypeSelectCom = 0;
  List<String> propertyType = ["Apartment", "Villa/House", "Row House", "Farm House", "Plot", "Pent House", "Others"];
  List<String> propertyTypeCom = ["Office Space", "Shop", "Ware House", "Commercial Land", "Hotel", "Showroom", "Others"];
  addToList() async{
    final query = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    FirebaseFirestore.instance.collection('propertyDetails').add({
      'location':new GeoPoint(first.coordinates.latitude,first.coordinates.longitude),
      'place': first.featureName
    });
  }
  Future addMarker() async{
    await showDialog(
        context: context,
        builder:(BuildContext context){
          return new SimpleDialog(
            title: Text("Add Marker Location",style: TextStyle(fontSize: 17.0),),
            children: <Widget>[
              new TextField(
                onChanged: (String enterLoc){
                  setState(() {
                    inputaddr=enterLoc;
                  });
                },
              ),
              new SimpleDialogOption(
                child: Text("Add It",style: TextStyle(color: Colors.blue),),
                onPressed: (){
                  addToList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                Text("Post As",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      // customRadio_2(owner_builder_broker[0], 0),
                      // SizedBox(width: 20),
                      customRadio_2(owner_builder_broker[1], 1),
                      SizedBox(width: 20),
                      customRadio_2(owner_builder_broker[2], 2),
                    ],
                  ),
                ), //Row of radiobutton
                Divider(),
                SizedBox(
                  height: 50 ,
                  child: AppBar(
                    backgroundColor: Colors.grey.shade50,
                    elevation: 0,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          icon: Text("Residential",style: TextStyle(fontSize: 18,color: Colors.indigo,fontWeight: FontWeight.bold),),
                        ),
                        Tab(
                          icon: Text("Commercial",style: TextStyle(fontSize: 18,color: Colors.indigo,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ), //nav bar
                Expanded(
                  flex:1,
                  child: TabBarView(
                    children: [
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 7,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          customRadio_1(sell_and_rent[0], 0),
                                          SizedBox(width: 20),
                                          customRadio_1(sell_and_rent[1], 1),
                                        ],
                                      ),
                                    ), //Radio button sell and rent
                                    SizedBox(height: 10.0,),
                                    Divider(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left:20),
                                      child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                    ), //Property type container
                                    SizedBox(height: 10.0,),
                                    // Container(
                                    //     child: Wrap(
                                    //       spacing: 10.0,
                                    //       runSpacing: 3.0,
                                    //       children: residentialWidgets.toList(),
                                    //     )
                                    // ), //Filterchip for residential

                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          propertyTypeRadio(propertyType[0], 0),
                                          SizedBox(width: 10),
                                          propertyTypeRadio(propertyType[1], 1),
                                          SizedBox(width: 10),
                                          propertyTypeRadio(propertyType[2], 2),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          propertyTypeRadio(propertyType[3], 3),
                                          SizedBox(width: 10),
                                          propertyTypeRadio(propertyType[4], 4),
                                          SizedBox(width: 10),
                                          propertyTypeRadio(propertyType[5], 5),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          propertyTypeRadio(propertyType[6], 6),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ), //Add location Container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_name_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Name",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Project Name
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: address_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Address
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: landmark_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Landmark",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Landmark
                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                    ),
                                    child: TextFormField(
                                      controller: city_controller_r,
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "City",
                                          hintStyle: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      //itemHeight: 20.0,
                                      value: _value2,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Select State"),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Anddhra Pradesh"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Arunachal Pradesh"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Assam"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Bihar"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Chhattisgarh"),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Goa"),
                                          value: 6,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Gujarat"),
                                          value: 7,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Haryana"),
                                          value: 8,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Himachal Pradesh"),
                                          value: 9,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Jharkhand"),
                                          value: 10,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Karnataka"),
                                          value: 11,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Kerala"),
                                          value: 12,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Madhya Pradesh"),
                                          value: 13,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Maharashtra"),
                                          value: 14,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Manipur"),
                                          value: 15,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Meghalaya"),
                                          value: 16,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Mizoram"),
                                          value: 17,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Nagaland"),
                                          value: 18,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Odisha"),
                                          value: 19,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Punjab"),
                                          value: 20,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Rajasthan"),
                                          value: 21,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sikkim"),
                                          value: 22,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Tamil Nadu"),
                                          value: 23,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Telangana"),
                                          value: 24,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Tripura"),
                                          value: 25,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Uttar Pradesh"),
                                          value: 26,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Uttarakhand"),
                                          value: 27,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("West Bengal"),
                                          value: 28,
                                        )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _value2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ), //City
                              SizedBox(height: 10.0),
                              // Container(
                              //   width: MediaQuery.of(context).size.width ,
                              //   height: 50,
                              //   padding: EdgeInsets.only(left: 15),
                              //   margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              //   ),
                              //   child: TextFormField(
                              //     controller: state_controller_r,
                              //     decoration: InputDecoration(
                              //         enabledBorder: InputBorder.none,
                              //         focusedBorder: InputBorder.none,
                              //         hintText: "State",
                              //         hintStyle: TextStyle(fontSize: 18)
                              //     ),
                              //   ),
                              // ), //State
                              //
                              // SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Upload Photos",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//upload photo container
                              SizedBox(height: 10.0,),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image1 != null
                                              ? Image.file(_image1)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage1();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image2 != null
                                              ? Image.file(_image2)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage2();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image3 != null
                                              ? Image.file(_image3)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage3();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),//Choose photo
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Property Detail",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//property details
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    customRadio_3(bhk[0], 0),
                                    SizedBox(width: 5),
                                    customRadio_3(bhk[1], 1),
                                    SizedBox(width: 5),
                                    customRadio_3(bhk[2], 2),
                                    SizedBox(width: 5),
                                    customRadio_3(bhk[3], 3),
                                  ],
                                ),
                              ),//bhk detail
                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                    ),
                                    child: TextFormField(
                                      controller: area_controller_r,
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "Area",
                                          hintStyle: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      //itemHeight: 20.0,
                                      value: _value1,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Sq. Meter"),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Are"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Hectare"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Feet"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Kilometer"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Yard"),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Mile"),
                                          value: 6,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Inch"),
                                          value: 7,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Guntha"),
                                          value: 8,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Vigha(23.5)"),
                                          value: 9,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Vigha(16)"),
                                          value: 10,
                                        )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _value1 = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: price_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Price",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ), //Price
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_description_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Description",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Project Description
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Construction Status",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//Construction status container
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    customRadio_4(construction_status[0], 0),
                                    SizedBox(width: 20),
                                    customRadio_4(construction_status[1], 1),
                                  ],
                                ),
                              ),//construction status button
                              SizedBox(height: 10.0,),
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: 50,
                              //   padding: EdgeInsets.only(left: 15),
                              //   margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              //   ),
                              //   child: TextField(
                              //     onChanged: (String enterLoc){
                              //       setState(() {
                              //         inputaddr=enterLoc;
                              //       });
                              //     },
                              //     //controller: addToMap,
                              //     decoration: InputDecoration(
                              //         enabledBorder: InputBorder.none,
                              //         focusedBorder: InputBorder.none,
                              //         hintText: "Add to Map",
                              //         hintStyle: TextStyle(fontSize: 18)
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 30.0,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    //uploadImageToFirebase(context);
                                    uploadMultipleImages1();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => MapBuilder(value:propertyRes.documentID)));
                                  },
                                  color: Colors.indigo,
                                  child: Center(child: Text("POST", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),//post button container

                              SizedBox(height: 30.0,)
                            ],
                          ),
                        ],
                      ), //residential
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 7,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          customRadio_1c(sell_and_rent_1c[0], 0),
                                          SizedBox(width: 20),
                                          customRadio_1c(sell_and_rent_1c[1], 1),
                                        ],
                                      ),
                                    ),//sell rent radio button
                                    SizedBox(height: 10,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left:20),
                                      child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                    ),//property type container
                                    SizedBox(height: 10.0,),
                                    // Container(
                                    //     child: Wrap(
                                    //       spacing: 10.0,
                                    //       runSpacing: 3.0,
                                    //       children: commercialWidgets.toList(),
                                    //     )
                                    // ),//Filter chip buttons
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          propertyTypeRadioCom(propertyTypeCom[0], 0),
                                          SizedBox(width: 10),
                                          propertyTypeRadioCom(propertyTypeCom[1], 1),
                                          SizedBox(width: 10),
                                          propertyTypeRadioCom(propertyTypeCom[2], 2),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          propertyTypeRadioCom(propertyTypeCom[3], 3),
                                          SizedBox(width: 10),
                                          propertyTypeRadioCom(propertyTypeCom[4], 4),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          propertyTypeRadioCom(propertyTypeCom[5], 5),
                                          SizedBox(width: 10),
                                          propertyTypeRadioCom(propertyTypeCom[6], 6),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//add location container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_name_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Name",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//project name commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: address_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//address commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: landmark_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Landmark",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//landmark container commercial
                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                    ),
                                    child: TextFormField(
                                      controller: city_controller_c,
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "City",
                                          hintStyle: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      //itemHeight: 20.0,
                                      value: _value2,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Select State"),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Anddhra Pradesh"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Arunachal Pradesh"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Assam"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Bihar"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Chhattisgarh"),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Goa"),
                                          value: 6,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Gujarat"),
                                          value: 7,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Haryana"),
                                          value: 8,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Himachal Pradesh"),
                                          value: 9,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Jharkhand"),
                                          value: 10,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Karnataka"),
                                          value: 11,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Kerala"),
                                          value: 12,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Madhya Pradesh"),
                                          value: 13,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Maharashtra"),
                                          value: 14,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Manipur"),
                                          value: 15,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Meghalaya"),
                                          value: 16,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Mizoram"),
                                          value: 17,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Nagaland"),
                                          value: 18,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Odisha"),
                                          value: 19,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Punjab"),
                                          value: 20,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Rajasthan"),
                                          value: 21,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sikkim"),
                                          value: 22,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Tamil Nadu"),
                                          value: 23,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Telangana"),
                                          value: 24,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Tripura"),
                                          value: 25,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Uttar Pradesh"),
                                          value: 26,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Uttarakhand"),
                                          value: 27,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("West Bengal"),
                                          value: 28,
                                        )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _value2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),//city container commercial
                              SizedBox(height: 10.0),
                              // Container(
                              //   width: MediaQuery.of(context).size.width ,
                              //   height: 50,
                              //   padding: EdgeInsets.only(left: 15),
                              //   margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              //   ),
                              //   child: TextFormField(
                              //     controller: state_controller_c,
                              //     decoration: InputDecoration(
                              //         enabledBorder: InputBorder.none,
                              //         focusedBorder: InputBorder.none,
                              //         hintText: "State",
                              //         hintStyle: TextStyle(fontSize: 18)
                              //     ),
                              //   ),
                              // ),//state container commercial
                              //
                              // SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Upload Photos",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//upload photo container
                              SizedBox(height: 10.0,),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image4 != null
                                              ? Image.file(_image4)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage4();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image5 != null
                                              ? Image.file(_image5)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage5();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _image6 != null
                                              ? Image.file(_image6)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              getImage6();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Property Detail",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ), //property detail container
                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.45,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                    ),
                                    child: TextFormField(
                                      controller: area_controller_c,
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "Area",
                                          hintStyle: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      //itemHeight: 20.0,
                                      value: _value1,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Sq. Meter"),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Are"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Hectare"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Feet"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Kilometer"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Yard"),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Mile"),
                                          value: 6,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Sq. Inch"),
                                          value: 7,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Guntha"),
                                          value: 8,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Vigha(23.5)"),
                                          value: 9,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Vigha(16)"),
                                          value: 10,
                                        )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _value1 = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: price_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Price",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),//price container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: detail_controller,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Maintenance",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_description_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Description",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//project description container
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Construction Status",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//construction status container
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    customRadio_4c(construction_status_4c[0], 0),
                                    SizedBox(width: 20),
                                    customRadio_4c(construction_status_4c[1], 1),
                                  ],
                                ),
                              ),//construction status buttons
                              SizedBox(height: 10.0,),
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: 50,
                              //   padding: EdgeInsets.only(left: 15),
                              //   margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              //   ),
                              //   child: TextField(
                              //     onChanged: (String enterLoc){
                              //       setState(() {
                              //         inputaddr=enterLoc;
                              //       });
                              //     },
                              //     //controller: addToMap,
                              //     decoration: InputDecoration(
                              //         enabledBorder: InputBorder.none,
                              //         focusedBorder: InputBorder.none,
                              //         hintText: "Add to Map",
                              //         hintStyle: TextStyle(fontSize: 18)
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height:30.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    //uploadImageToFirebase1(context);
                                    uploadMultipleImages2();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => MapBuilder(value:propertyCom.documentID)));
                                  },
                                  color: Colors.indigo,
                                  child: Center(child: Text("POST", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),//post button
                              SizedBox(height: 30.0,)
                            ],
                          ),
                        ],
                      ), //commercial
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void changeIndex_sell_rent_1(int index){
    setState(() {
      selectedIndex1=index;
    });
  }
  void changeIndex_sell_rent_1c(int index){
    setState(() {
      selectedIndex1c=index;
    });
  }
  void changeIndex_sell_rent_2(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  void changeIndex_sell_rent_3(int index){
    setState(() {
      selectedIndex2=index;
    });
  }
  void changeIndex_sell_rent_4(int index){
    setState(() {
      selectedIndex3=index;
    });
  }
  void changeIndex_sell_rent_4c(int index){
    setState(() {
      selectedIndex4c=index;
    });
  }
  void propertyTypeIndex(int index){
    setState(() {
      propertyTypeSelect=index;
    });
  }
  void propertyTypeIndexCom(int index){
    setState(() {
      propertyTypeSelectCom=index;
    });
  }

  Widget customRadio_4(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_4(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex3 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex3 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_3(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_3(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex2 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex2 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_2(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_2(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_1(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_1(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex1 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex1 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_1c(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_1c(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex1c == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex1c == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_4c(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_4c(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex4c == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex4c == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget propertyTypeRadio(String txt, int index) {
    return OutlineButton(
      splashColor: Colors.green,
      onPressed: () => propertyTypeIndex(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      borderSide: BorderSide(color: propertyTypeSelect == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: propertyTypeSelect == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Widget propertyTypeRadioCom(String txt, int index) {
    return OutlineButton(
      splashColor: Colors.green,
      onPressed: () => propertyTypeIndexCom(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      borderSide: BorderSide(color: propertyTypeSelectCom == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: propertyTypeSelectCom == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
}
// class filterChipWidget extends StatefulWidget {
//   final String chipName;
//
//   filterChipWidget({Key key, this.chipName}) : super(key: key);
//
//   @override
//   _filterChipWidgetState createState() => _filterChipWidgetState();
// }
//
// class _filterChipWidgetState extends State<filterChipWidget> {
//   var _isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return FilterChip(
//         label: Text(widget.chipName),
//         labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
//         selected: _isSelected,
//         shape:RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//               30.0),),
//         backgroundColor: Colors.indigo.shade50,
//         onSelected: (isSelected) {
//           setState(() {
//             _isSelected = isSelected;
//           });
//         },
//         selectedColor: Colors.indigo.shade100);
//   }
// }
//
