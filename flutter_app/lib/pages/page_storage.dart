import 'package:flutter/material.dart';
import 'package:flutter_app/util/storage.dart';
import 'package:flutter_app/widgets/widget_appbar.dart';
import '../head.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidget createState() => _CounterWidget();
}

class _CounterWidget extends State<CounterWidget> {
  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '存储',
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                onPressed: _incrementCounter, child: Text('Increment Counter')),
            RaisedButton(onPressed: _getCounter, child: Text('Get Counter')),
            Text(
              countString,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'result：' + localCount,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  _incrementCounter() async {
    String value = await Save().getDataWithKey('counter');
    setState(() {
      countString = '$value 1';
    });

    Save().setData('counter', countString);
  }

  _getCounter() async {
    String value = await Save().getDataWithKey('counter');
    setState(() {
      localCount = value;
    });
  }
}
