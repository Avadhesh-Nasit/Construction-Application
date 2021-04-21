import 'package:flutter/material.dart';
class searchDemo extends StatefulWidget {
  @override
  _searchDemoState createState() => _searchDemoState();
}

class _searchDemoState extends State<searchDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.clear),onPressed: (){},)

    );
  }
}
