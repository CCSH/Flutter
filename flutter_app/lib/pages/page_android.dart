import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AndroidPage extends StatefulWidget {
  @override
  _AndroidPageState createState() => _AndroidPageState();
}

class _AndroidPageState extends State<AndroidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('安卓'),
      ),
    );
  }
}
