import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/sh_extension_globalkey.dart';
import 'package:flutter_app/util/helper_data.dart';

class CSHTable extends StatefulWidget {
  @override
  _CSHTableState createState() => _CSHTableState();
}

class _CSHTableState extends State<CSHTable>
    with SingleTickerProviderStateMixin {
  int _current = -1;

  ScrollController _scrollC;
  PageController _pageC;
  Animation _animation;
  AnimationController _controller;
  Tween _tween;

  Map _keyMap = {};
  List _dataSoure = [];
  double _lineW = 30;
  double _lineX = 0;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 10; i++) {
      _keyMap[i] = GlobalKey();
      if (Random().nextInt(3) == 2) {
        _dataSoure.add('标签 $i ${WordPair.random()} ${WordPair.random()}');
      } else {
        _dataSoure.add('标签 $i ${WordPair.random()}');
      }
    }

    _tween = Tween(begin: 0.0, end: 0.0);
    _tween.end = 0.0;

    _controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _animation = _tween.animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    //为了控制那条线
    _scrollC = ScrollController()
      ..addListener(() {
        setState(() {
          _lineX = -_scrollC.position.pixels;
        });
      });
    _pageC = PageController();
    // ..addListener(() {
    //   _handleOffSet((_pageC.position.pixels / CommonData.screenW));
    // });

    //界面绘制完毕
    WidgetsBinding.instance.addPostFrameCallback((Duration dur) {
      _startAnimation(0, false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义标签页'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildTable(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          height: 50,
          child: ListView.builder(
            controller: _scrollC,
            scrollDirection: Axis.horizontal,
            itemCount: _dataSoure.length,
            itemBuilder: (BuildContext context, int index) {
              Widget widget = Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                key: _keyMap[index],
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  child: Text(_dataSoure[index]),
                  color: Colors.cyan,
                  onPressed: () {
                    _startAnimation(index, false);
                  },
                ),
              );
              return widget;
            },
          ),
        ),
        Positioned(
          top: 50,
          left: _lineX,
          child: Container(
            width: _lineW,
            height: 4,
            //当作中心点
            margin: EdgeInsets.only(
                left: max(_animation.value - (_lineW / 2), 0.0)),
            color: Colors.red,
            child: null,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Container(
        color: Colors.orange,
        margin: EdgeInsets.only(top: 4),
        child: PageView.builder(
          controller: _pageC,
          itemBuilder: ((BuildContext context, int index) {
            return Container(
              child: Center(
                child: Text(
                  '我是第$index页',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }),
          itemCount: _keyMap.length,
          physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
          onPageChanged: (index) {
            _startAnimation(index, true);
          },
        ),
      ),
    );
  }

  /// 动画开始
  void _startAnimation(int index, bool isScroll) {
    if (_current == index) {
      return;
    }
    print('当前 $index');
    _current = index;

    _tween.begin = _animation.value;
    //取出当前点击的组件
    GlobalKey key = _keyMap[_current];
    if (key.currentContext != null) {
      key.setOffset(Offset(_scrollC.position.pixels, 0.0));
      //让线跟当前组件一样宽
      _lineW = key.width() - (2 * 10);

      //找到中心点
      _tween.end = key.x() + (key.width() / 2);

      double scrollOffset = _tween.end - (CommonData.screenW / 2);
      if (scrollOffset > _scrollC.position.maxScrollExtent) {
        scrollOffset = _scrollC.position.maxScrollExtent;
      } else if (scrollOffset < 0) {
        scrollOffset = 0;
      }

      if (_pageC.position.pixels != _current * CommonData.screenW &&
          !isScroll) {
        _pageC.jumpTo(
          _current * CommonData.screenW,
        );
      }
      //头部偏移
      _scrollC.animateTo(
        scrollOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

      //线偏移
      _controller.forward(from: 0);
    }
  }
}
