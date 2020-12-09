import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/http/http_interface.dart';
import 'package:flutter_app/util/http/http_model.dart';
import 'package:flutter_app/util/router.dart';
import 'package:flutter_app/util/toast_util.dart';
import 'package:flutter_app/widgets/custom_appbar.dart';

/// MARK:
//  @Description: 类描述
//  @Author: 陈胜辉
//  @Date: 2020-12-07 14:43:04
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2020-12-09 10:31:20
//  @Deprecated: 否
//  备注
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
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
                    RouteName.login +
                        RouterUtil.setRouterParams({
                          'param': '1234',
                          'title': '标题',
                        }),
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
                child: Text('布局'),
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
                child: Text('二维码生成与保存'),
                onPressed: () {
                  RouterUtil.navigateTo(context, RouteName.cshQr);
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
            ],
          ),
        ),
      ),
    );
  }
}
