import 'package:flutter/material.dart';
import 'package:flutter_app/util/data_helper.dart';
import 'package:flutter_app/extension/sh_extension_globalkey.dart';
import 'package:flutter_app/widgets/custom_appbar.dart';
import 'package:flutter_app/util/scction_head_helper.dart';

class CSHColumnList extends StatefulWidget {
  @override
  _CSHListState createState() => _CSHListState();
}

class _CSHListState extends State<CSHColumnList> {
  ScrollController _listScrollC = ScrollController();
  SHSectionHeadConfig config = SHSectionHeadConfig();

  @override
  void initState() {
    super.initState();

    //初始化model
    config.keyList = [
      GlobalKey(debugLabel: '1'),
      GlobalKey(debugLabel: '9'),
      GlobalKey(debugLabel: '20'),
      GlobalKey(debugLabel: '30'),
    ];
    config.position = CommonData.navAndStatusH;

    _listScrollC.addListener(() {
      if (config.handleData()) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: CustomAppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          middleText: '列悬浮',
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _listScrollC,
              itemBuilder: (BuildContext context, int index) {
                for (var i = 0; i < config.keyList.length; i++) {
                  GlobalKey key = config.keyList[i];
                  if (key.debugLabel() == index.toString()) {
                    //设置头部
                    return getHeadView(i, key);
                  }
                }
                //设置内容
                return Container(
                  color: Colors.red,
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
            handleHead(),
          ],
        ));
  }

  /// MARK:处理悬浮头部
  //  @LastEditors: 陈胜辉
  //  @Version: 版本号, YYYY-MM-DD
  //  @param {type}
  //  @return:
  //  @Deprecated: 否
  //  备注
  Widget handleHead() {
    //需要悬浮
    if (config.currentIndex >= 0) {
      return Positioned(
        top: config.offset,
        child: getHeadView(config.currentIndex, null),
      );
    }

    return Container();
  }

  /// MARK:获取头部组件
  //  @LastEditors: 陈胜辉
  //  @Version: 版本号, YYYY-MM-DD
  //  @param {type}
  //  @return:
  //  @Deprecated: 否
  //  备注
  Widget getHeadView(int index, Key key) {
    return Container(
      key: key,
      height: 90,
      width: CommonData.screenW,
      color: Colors.cyan,
      alignment: Alignment.center,
      child: Text(
        '我是head === $index',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
