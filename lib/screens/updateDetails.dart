import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_application/screens/homeScreenBuilderAndBroker.dart';
import 'package:flutter/material.dart';
class updateDetails extends StatefulWidget {
  final String value;
  final String projectName;
  final String status;

  const updateDetails({Key key, this.value,this.projectName,this.status}) : super(key: key);

  @override
  _updateDetailsState createState() => _updateDetailsState(value,projectName,status);
}

class _updateDetailsState extends State<updateDetails> {
  final String value;
  final String projectName;
  final String status;
  List<String> sell_and_rent=["Sell","Rent"];
  int selectedIndex=0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController projectName1 = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController status1 = TextEditingController();
  TextEditingController description1 = TextEditingController();
  TextEditingController sellOrRent = TextEditingController();

  _updateDetailsState(this.value,this.projectName,this.status);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
                    controller: projectName1,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: projectName + " (Project Name)",
                        hintStyle: TextStyle(fontSize: 18)
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value)
                    {
                      if(value==null)
                      {
                        return 'Enter Project Name';
                      }
                      return null;
                    },
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
                    controller: status1,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: status + " (Status)",
                        hintStyle: TextStyle(fontSize: 18)
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Enter Status';
                      }
                      return null;
                    },
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
                    controller: price,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Price",
                        hintStyle: TextStyle(fontSize: 18)
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Enter Price';
                      }
                      return null;
                    },
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
                    controller: description1,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(fontSize: 18)
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Enter Description';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.0,),
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
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if(formKey.currentState.validate()){
                        formKey.currentState.save();
                        try{
                          update();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => HomeScreen1()));
                        }catch(e){
                          print(e.message);
                        }
                      }
                    },
                    color: Colors.indigo,
                    child: Center(child: Text("Update", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future <void> update() async {
    // await FirebaseFirestore.instance.collection("propertyDetails").doc(value).update({
    //   'projectName': projectName.text,
    // }).then((documentReference) {
    // }).catchError((e) {
    //   print(e);
    // });
    await FirebaseFirestore.instance.collection('propertyDetails').doc(value).update({
     'projectName': projectName1.text,
      'price':price.text,
      'status':status1.text,
      'description':description1.text,
      'sellOrRent':sell_and_rent[selectedIndex]
    });
  }
  void changeIndex_sell_rent_1(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  Widget customRadio_1(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_1(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
}
