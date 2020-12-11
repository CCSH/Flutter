import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/widget_appbar.dart';
// import 'package:share/share.dart';
// import 'package:platform_view/platform_view.dart';

class CSHLayout extends StatefulWidget {
  @override
  _CSHLayoutState createState() => _CSHLayoutState();
}

class _CSHLayoutState extends State<CSHLayout> {
  // UILabelCallBack _callback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '布局',
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.orange,
              width: 200,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Colors.cyan,
                  filled: true,
                  hintText: '这是多行文本',
                ),
                maxLines: 5,
              ),
            ),
            RaisedButton(
              child: Text('分享'),
              splashColor: Colors.transparent,
              color: Colors.cyan,
              onPressed: () {
                // Share.share('我是。。。。。。');
              },
            ),
            RaisedButton(
              child: Text('刷新原生view'),
              color: Colors.cyan,
              onPressed: () {
                // _callback.reloadView();
              },
            ),
            Container(
              width: 200,
              height: 30,
              color: Colors.orange,
              // child: UILabel(onCreated: (UILabelCallBack callback) {
              //   _callback = callback;
              // }),
            ),
          ],
        ),
      ),
    );
  }
}
