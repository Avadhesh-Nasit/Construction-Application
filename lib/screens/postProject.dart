import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class PostProperty extends StatefulWidget {
  @override
  _PostPropertyState createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {

  Future<void> _optionsDialogBox() {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: ()async {
                      var picture = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: ()async{
                      var gallery = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  int group=1;
  int sellrentradio=1;
  bool apartment=false;
  bool villa=false;
  bool rowhouse=false;
  bool farmhouse=false;
  bool plot=false;
  bool pentahouse=false;
  bool other=false;
  bool officespace=false;
  bool shop=false;
  bool warehouse=false;
  bool commercialland=false;
  bool hotel=false;
  bool showroom=false;
  List<String> sell_and_rent=["Sell","Rent"];
  List<String> owner_builder_broker=["Owner","Builder","Broker"];
  int selectedIndex=0;
  int selectedIndex1=0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text("Post Property"),
          backgroundColor: Colors.indigo.shade300,

        ),
        body: Container(
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
                          customRadio_2(owner_builder_broker[0], 0),
                          SizedBox(width: 20),
                          customRadio_2(owner_builder_broker[1], 1),
                          SizedBox(width: 20),
                          customRadio_2(owner_builder_broker[2], 2),
                        ],
                      ),
                    ),
                  //Row of radiobutton
              SizedBox(height: 10.0,),
              Container(
                  height: 30.0,
                  margin: EdgeInsets.only(left: 5.0),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left:20),
                      child: Text("Property",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                  )
              ), //property
              Padding(padding: EdgeInsets.only(top: 10.0)),
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
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left:20),
                                    child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: apartment,
                                          onChanged:(bool value){
                                            setState(() {
                                              apartment=value;
                                            });
                                          }
                                      ),
                                      Text("Apartment"),
                                      Checkbox(
                                          value: villa,
                                          onChanged:(bool value){
                                            setState(() {
                                              villa=value;
                                            });
                                          }
                                      ),
                                      Text("Villa/House"),
                                      Checkbox(
                                          value: rowhouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              rowhouse=value;
                                            });
                                          }
                                      ),
                                      Text("Row House"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: farmhouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              farmhouse=value;
                                            });
                                          }
                                      ),
                                      Text("Farm House"),
                                      Checkbox(
                                          value: plot,
                                          onChanged:(bool value){
                                            setState(() {
                                              plot=value;
                                            });
                                          }
                                      ),
                                      Text("Plot"),
                                      Checkbox(
                                          value: pentahouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              pentahouse=value;
                                            });
                                          }
                                      ),
                                      Text("Penta House"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: other,
                                          onChanged:(bool value){
                                            setState(() {
                                              other=value;
                                            });
                                          }
                                      ),
                                      Text("Others"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              width: MediaQuery.of(context).size.width ,
                              height: 50,
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "State",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "City",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
                            ),
                            // SizedBox(height: 10.0,),
                            // InkWell(
                            //   child: Container(
                            //     color: Colors.indigo,
                            //     height: 30.0,
                            //   ),
                            //   onTap: (){
                            //     _optionsDialogBox();
                            //   },
                            // ),
                            SizedBox(height: 10.0,),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        color: Colors.white,
                                        child: Center(
                                          child: Icon(Icons.photo_library_outlined,size: 40.0,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        color: Colors.white,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Center(
                                          child: Icon(Icons.photo_camera_outlined,size: 40.0,),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left:20),
                                child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Project Name",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Address",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Landmark",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Project Description",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
                            ),
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
                                        customRadio_1(sell_and_rent[0], 0),
                                        SizedBox(width: 20),
                                        customRadio_1(sell_and_rent[1], 1),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left:20),
                                    child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: officespace,
                                          onChanged:(bool value){
                                            setState(() {
                                              officespace=value;
                                            });
                                          }
                                      ),
                                      Text("Office Space"),
                                      Checkbox(
                                          value: shop,
                                          onChanged:(bool value){
                                            setState(() {
                                              shop=value;
                                            });
                                          }
                                      ),
                                      Text("Shop"),
                                      Checkbox(
                                          value: warehouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              warehouse=value;
                                            });
                                          }
                                      ),
                                      Text("Ware House"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: commercialland,
                                          onChanged:(bool value){
                                            setState(() {
                                              commercialland=value;
                                            });
                                          }
                                      ),
                                      Text("Commercial Land"),
                                      Checkbox(
                                          value: hotel,
                                          onChanged:(bool value){
                                            setState(() {
                                              hotel=value;
                                            });
                                          }
                                      ),
                                      Text("Hotel"),
                                      Checkbox(
                                          value: showroom,
                                          onChanged:(bool value){
                                            setState(() {
                                              showroom=value;
                                            });
                                          }
                                      ),
                                      Text("Show Room"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: other,
                                          onChanged:(bool value){
                                            setState(() {
                                              other=value;
                                            });
                                          }
                                      ),
                                      Text("Others"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              width: MediaQuery.of(context).size.width ,
                              height: 50,
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "State",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "City",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        color: Colors.white,
                                        child: Center(
                                          child: Icon(Icons.photo_library_outlined,size: 40.0,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        color: Colors.white,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Center(
                                          child: Icon(Icons.photo_camera_outlined,size: 40.0,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left:20),
                                child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Project Name",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Address",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Landmark",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
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
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Project Description",
                                    hintStyle: TextStyle(fontSize: 18)
                                ),
                              ),
                            ),
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
    );
  }
  void changeIndex_sell_rent_1(int index){
    setState(() {
      selectedIndex1=index;
    });
  }
  void changeIndex_sell_rent_2(int index){
    setState(() {
      selectedIndex=index;
    });
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
}
