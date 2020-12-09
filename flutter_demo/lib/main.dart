import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:fluro/fluro.dart';

void main() {
  if (Platform.isAndroid) {
    // 沉浸式状态栏
    SystemUiOverlayStyle style =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 配置路由
    Routes.configRoutes();
    //界面
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteName.root,
      // 设置主题主颜色与按钮颜色
      theme: new ThemeData(
        primaryColor: Colors.red,
        buttonColor: Colors.green,
        splashColor: Colors.transparent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        ),
      ),
      onGenerateRoute: FluroRouter.appRouter.generator,
    );
  }
}
