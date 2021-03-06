import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/util/router.dart';
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
  //页面监听
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    // 配置路由
    Routes.configRoutes();
    // 全局设置
    return MaterialApp(
      //页面监听
      navigatorObservers: [routeObserver],
      //debug标签
      debugShowCheckedModeBanner: false,
      title: 'Flutter APP',
      // initialRoute: Navigator.defaultRouteName,
      onGenerateRoute: FluroRouter.appRouter.generator,
      // 主题
      theme: ThemeData(
        primaryColor: Colors.red,
        buttonColor: Colors.green,
        splashColor: Colors.transparent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        ),
      ),
    );
  }
}
