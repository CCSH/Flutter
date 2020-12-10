import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/http/http_interface.dart';
import 'package:flutter_app/util/http/http_model.dart';
import 'package:flutter_app/util/router.dart';
import 'package:flutter_app/util/toast_util.dart';
import 'package:flutter_app/widgets/widget_appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        defaultLeft: false,
        middleText: '陈胜辉',
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                borderRadius: BorderRadius.circular(0),
                pressedOpacity: 0.8,
                color: Colors.blue,
                minSize: 0,
                child: Container(
                  width: 90,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(
                    '注册页',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onPressed: () {
                  RouterUtil.navigateTo(
                    context,
                    RouteName.registered,
                    params: {
                      'param': '1234',
                      'title': '标题',
                    },
                    block: ((value) {
                      if (value != null) {
                        showToast(value);
                      }
                    }),
                  );
                },
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('导航栏'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshNav);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('调用原生view'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshLayout);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('动画'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshAnimated);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('列悬浮'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshColumnList);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('行悬浮'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshRowList);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('自定义标签页'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshTable);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('分页'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshPaging);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('界面周期'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshCycle);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('请求'),
                onPressed: () {
                  Interface.homeList()
                    ..then((DataModel value) {
                      if (value.data != null) {
                        showToast('收到数据');
                      }
                    });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('加载'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.load);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
