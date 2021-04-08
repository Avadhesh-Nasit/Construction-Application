import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
class propertyDetail extends StatefulWidget {
  @override
  _propertyDetailState createState() => _propertyDetailState();
}

class _propertyDetailState extends State<propertyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 350,
                      child: Stack(
                        children: [
                          Container(
                            child: ClipRRect(
                              // child: Image.asset(
                              //     'images/property.jpg',
                              //     width: MediaQuery.of(context).size.width,
                              //     height: MediaQuery.of(context).size.height,
                              //     fit:BoxFit.fill
                              // ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(right: 20, top: 20),
                            child: FavoriteButton(
                              isFavorite: false,
                              valueChanged: (_isFavorite) {
                                print('Is Favorite : $_isFavorite');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: Row(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
