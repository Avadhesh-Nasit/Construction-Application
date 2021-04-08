import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
class emiCalculator extends StatefulWidget {
  @override
  _emiCalculatorState createState() => _emiCalculatorState();
}

class _emiCalculatorState extends State<emiCalculator> {
  String _emiResult = "";

  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Text("EMI Calculator"),
            elevation: 0.0

        ),

        body: Center(
            child: ListView(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0,),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                                Container(
                                  width: 150.0,
                                  child: Text(
                                    "Principal Amount",
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 15),
                                  margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    controller: _principalAmount,
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Enter Principal Amount",
                                        hintStyle: TextStyle(fontSize: 18)
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 150.0,
                                child: Text(
                                  "Interest Rate",
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 15),
                                  margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    controller: _interestRate,
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Enter Interest Rate",
                                        hintStyle: TextStyle(fontSize: 18)
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 150.0,
                                child: Text(
                                  "Tenure",
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 15),
                                  margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    controller: _tenure,
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Enter Tenure",
                                        hintStyle: TextStyle(fontSize: 18)
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70.0,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 50,
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3, left: MediaQuery.of(context).size.width * 0.3),
                          child: RaisedButton(
                            onPressed:_handleCalculation,
                            color: Colors.indigo,
                            child: Center(child: Text("Calculate", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        // Flexible(
                        //     fit: FlexFit.loose,
                        //     child: FlatButton(
                        //         onPressed: _handleCalculation,
                        //         child: Text("Calculate"),
                        //         color: Colors.redAccent,
                        //         textColor: Colors.white,
                        //         padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)
                        //     )
                        // ),
                        emiResultsWidget(_emiResult)
                      ],
                    )
                )
              ],
            )
        )
    );
  }

  void _handleCalculation() {
    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = int.parse(_tenure.text)*12;

    A = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));

    _emiResult = A.toStringAsFixed(2);

    setState(() {

    });
  }


  Widget emiResultsWidget(emiResult) {
    String _emiResult = emiResult;
    return
      Container(
          margin: EdgeInsets.only(top: 40.0),
          child:  Column(
              children: [
                Text("Your Monthly EMI is",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    )
                ),
                Container(
                    child: Text(_emiResult,
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold
                        ))
                )
              ]
          )
      );
  }
}
