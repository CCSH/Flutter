import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/middle.dart';
import 'package:flutter_app/pages/mine.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  List<Widget> pages = List<Widget>();

  @override
  void initState() {
    super.initState();
    pages.addAll([
      HomePage(),
      MiddlePage(),
      MinePage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 苹果风格底部导航
      bottomNavigationBar: CupertinoTabBar(
          border: Border(top: BorderSide(width: 1, color: Colors.grey[200])),
          backgroundColor: Colors.white,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              label: '练习',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.accessibility_new,
                size: 30,
              ),
              label: '我的',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (int i) {
            setState(() {
              _currentIndex = i;
            });
          }),
      body: pages[_currentIndex],
    );
  }
}
