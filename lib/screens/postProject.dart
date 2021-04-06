import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PostProperty extends StatefulWidget {
  @override
  _PostPropertyState createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Post Property"),
          backgroundColor: Colors.indigo.shade300,

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text("I am",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                    Radio(
                      value: 1,
                      groupValue: group,
                      onChanged:(T){
                        print(T);
                        setState(() {
                          group=T;
                        });
                      },
                    ),
                    Text("Owner"),
                    Radio(
                      value: 2,
                      groupValue: group,
                      onChanged:(T){
                        print(T);
                        setState(() {
                          group=T;
                        });
                      },
                    ),
                    Text("Builder"),
                    Radio(
                      value: 3,
                      groupValue: group,
                      onChanged:(T){
                        print(T);
                        setState(() {
                          group=T;
                        });
                      },
                    ),
                    Text("Broker"),
                  ],
                ),
              ), //Row of radiobutton
              Container(
                  height: 30.0,
                  margin: EdgeInsets.only(left: 5.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Property",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),)
              ), //property
              Padding(padding: EdgeInsets.only(top: 10.0)),
              SizedBox(
                height: 50 ,
                child: AppBar(
                  elevation: 0,
                  //backgroundColor: Colors.white70,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Text("Residential"),
                      ),
                      Tab(
                        icon: Text("Commercial"),
                      )
                    ],
                  ),
                ),
              ), //nav bar
              Expanded(
                flex:1,
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              SizedBox(height: 7,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: sellrentradio,
                                    onChanged:(T){
                                      print(T);
                                      setState(() {
                                        sellrentradio=T;
                                      });
                                    },
                                  ),
                                  Text("Sell",style: TextStyle(fontSize: 20.0),),
                                  Radio(
                                    value: 2,
                                    groupValue: sellrentradio,
                                    onChanged:(T){
                                      print(T);
                                      setState(() {
                                        sellrentradio=T;
                                      });
                                    },
                                  ),
                                  Text("Rent",style: TextStyle(fontSize: 20.0)),
                                ],
                              ),
                              Text("Property Type",style: TextStyle(fontSize: 25.0),),
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
                      ],
                    ), //residential
                    Column(
                      children: [
                        Container(
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              SizedBox(height: 7,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: sellrentradio,
                                    onChanged:(T){
                                      print(T);
                                      setState(() {
                                        sellrentradio=T;
                                      });
                                    },
                                  ),
                                  Text("Sell",style: TextStyle(fontSize: 20.0),),
                                  Radio(
                                    value: 2,
                                    groupValue: sellrentradio,
                                    onChanged:(T){
                                      print(T);
                                      setState(() {
                                        sellrentradio=T;
                                      });
                                    },
                                  ),
                                  Text("Rent",style: TextStyle(fontSize: 20.0)),
                                ],
                              ),
                              Text("Property Type",style: TextStyle(fontSize: 25.0),),
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
                      ],
                    ), //commercial
                  ],
                ),
              ),
              Container(
                // height: 100.0,
                // color: Colors.pink,
                child: Column(
                  children: [
                    Container(
                        height:50.0,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter State",
                              hintStyle: TextStyle(fontSize: 18),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        )
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                        height:50.0,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter City",
                              hintStyle: TextStyle(fontSize: 18),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        )
                    ),
                    SizedBox(height: 10.0,)
                  ],
                ),
              ),
              Container(
                height: 200.0,
                child: Column(
                  children: [
                    SizedBox(height: 130.0,),
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: 40.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("NEXT",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                            Icon(Icons.navigate_next,color: Colors.white,size: 35.0,)
                          ],
                        ),
                        onPressed: (){},
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
