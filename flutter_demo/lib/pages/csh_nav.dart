// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/custom_appbar.dart';
import 'dart:ui';

class CSHNav extends StatefulWidget {
  @override
  _CSHNavState createState() => _CSHNavState();
}

class _CSHNavState extends State<CSHNav> {
  double scrollY = 0;
  ScrollController _listScrollC = ScrollController();
  @override
  void initState() {
    super.initState();
    _listScrollC.addListener(() {
      print('=== ${_listScrollC.position.pixels}');

      setState(() {
        scrollY = _listScrollC.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _configUI(context);
  }

  Widget _configUI(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        dialogBackgroundColor: Colors.transparent,
        cursorColor: Colors.transparent,
        accentColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: _configAppBar(),
        body: _configBody(),
      ),
    );
  }

  Widget _configBody() {
    return Container(
      color: Colors.red,
      child: ListView.builder(
        controller: _listScrollC,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              '我是第 --- $index',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          );
        },
        itemCount: 50,
      ),
    );
  }

  Widget _configAppBar() {
    double opacity = (scrollY / 44);

    return CustomAppBar(
      opacity: opacity,
      middleText: '我是导航栏',
      // height: CommonData.navH,
      // middle: Container(
      //   alignment: Alignment.center,
      //   child: Text(
      //     '我是自定义导航栏',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 18,
      //     ),
      //   ),
      // ),
      // actionsMaxW: 0,
      // leftActions: [
      //   CupertinoButton(
      //     pressedOpacity: 0.5,
      //     padding: EdgeInsets.only(left: 0),
      //     child: Icon(
      //       CupertinoIcons.back,
      //       size: 25,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       RouterUtil.pop(context);
      //     },
      //   ),
      //   CupertinoButton(
      //     pressedOpacity: 0.5,
      //     padding: EdgeInsets.only(left: 0),
      //     child: Icon(
      //       CupertinoIcons.refresh,
      //       size: 30,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       showToast('点击了刷新');
      //     },
      //   ),
      // ],
      // rightActions: [
      //   CupertinoButton(
      //     padding: EdgeInsets.only(left: 0),
      //     child: Icon(
      //       Icons.share,
      //       size: 20,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       showToast('点击了分享');
      //     },
      //   ),
      //   CupertinoButton(
      //     padding: EdgeInsets.only(left: 0),
      //     child: Icon(
      //       Icons.more_horiz,
      //       size: 25,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       showToast('点击了更多');
      //     },
      //   ),
      // ],
      // background: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [Colors.amberAccent, Colors.lightBlue, Colors.red],
      //     ),
      //   ),
      // ),
      // background: Image.asset(
      //   "assets/image/bg.png",
      //   fit: BoxFit.cover,
      // ),
      // backgroundColor: '#66365AF7'.toColor(),
    );
  }
}
