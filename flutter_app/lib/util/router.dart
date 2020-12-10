import 'package:flutter_app/extension/sh_extension_string.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app/pages/android.dart';
import 'package:flutter_app/pages/csh_animated.dart';
import 'package:flutter_app/pages/csh_column_list.dart';
import 'package:flutter_app/pages/csh_cycle.dart';
import 'package:flutter_app/pages/csh_nav.dart';
import 'package:flutter_app/pages/csh_paging.dart';
import 'package:flutter_app/pages/csh_row_list.dart';
import 'package:flutter_app/pages/csh_table.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/ios.dart';
import 'package:flutter_app/pages/load.dart';
import 'package:flutter_app/pages/reg.dart';
import 'package:flutter_app/pages/root.dart';
import 'dart:convert' as convert;
import 'package:flutter_app/util/toast_util.dart';

typedef _CallBack = void Function(dynamic result);

class RouterUtil {
  //路由参数
  static const String _param = 'router_param';

  // MARK 跳转到指定页面
  static navigateTo(BuildContext context, String url,
      {Map params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transType = TransitionType.inFromRight,
      _CallBack block}) {
    //有参数
    if (params != null) {
      url += RouterUtil.setRouterParams(params);
    }
    FluroRouter.appRouter.navigateTo(
      context,
      url,
      transition: transType,
      replace: replace,
      clearStack: clearStack,
    )..then((value) {
        if (block != null) {
          block(value);
        }
      });
  }

  // MARK 返回上一个页面
  static Future<bool> pop(BuildContext context, {dynamic param}) {
    return Navigator.maybePop(context, param);
  }

  // MARK 返回到已经存在指定页面
  static popToRouter(BuildContext context, String url) {
    Navigator.popUntil(context, ModalRoute.withName(url));
  }

  // MARK 处理入参
  static String setRouterParams(dynamic params) {
    //无参数
    if (null == params) {
      return '';
    }
    if (params is Map) {
      //转json
      params = convert.jsonEncode(params);
    }
    //断言
    assert((params is String), '参数类型不正确 参数格式只能是 Json 或 Map');
    String str = params;
    //编码中文
    str = str.toCoding();
    //拼接参数
    return '?' + _param + '=$str';
  }

  // MARK 处理出参
  static Map getRouterParams(Map params) {
    if (params.length == 0) {
      return {};
    }
    Map temp = {};

    //获取内容
    String value = params[_param].first;
    //解码中文
    value = value.toDeCoding();
    //转map
    temp = convert.jsonDecode(value);

    return temp;
  }
}

// MARK 路由名
class RouteName {
  // 跟目录
  static const String root = '/';
  // 主页
  static const String home = '/home';
  // ios
  static const String ios = '/ios';
  // 安卓
  static const String android = '/android';

  // 注册
  static const String registered = '/registered';
  // 界面周期页面 - csh
  static String cshPage = '/csh_page';
  // 注册页面 - csh
  static String cshReg = '/csh_reg';
  // 导航栏页面 - csh
  static String cshNav = '/csh_nav';
  // 布局页面 - csh
  static String cshLayout = '/csh_layout';
  // 动画页面 - csh
  static String cshAnimated = '/csh_animated';
  // 列页面 - csh
  static String cshColumnList = '/csh_column_list';
  // 行页面 - csh
  static String cshRowList = '/csh_row_list';
  // 表格页面 - csh
  static String cshTable = '/csh_table';
  // 分页页面 - csh
  static String cshPaging = '/csh_paging';
  // 界面周期页面 - csh
  static String cshCycle = '/csh_cycle';
  // 加载
  static String load = '/load';
}

// MARK 路由设置
class Routes {
  // MARK 配置routes
  static void configRoutes() {
    var router = FluroRouter.appRouter;
    router.notFoundHandler =
        Handler(handlerFunc: (BuildContext context, Map params) {
      showToast("route is not find !");
      return null;
    });

    // 注册路由
    getRoutList().forEach((url, func) {
      router.define(url, handler: Handler(handlerFunc: func));
    });
  }

  // MARK 路由列表
  static Map getRoutList() {
    return {
      RouteName.root: (context, params) => RootPage(),
      RouteName.home: (context, params) => HomePage(),
      RouteName.ios: (context, params) => IOSPage(),
      RouteName.android: (context, params) => AndroidPage(),
      RouteName.registered: (context, params) {
        Map param = RouterUtil.getRouterParams(params);
        return RegPage(
          param: param,
        );
      },
      RouteName.cshNav: (context, params) => CSHNav(),
      RouteName.cshAnimated: (conttext, params) => AnimatedListSample(),
      RouteName.cshColumnList: (conttext, params) => CSHColumnList(),
      RouteName.cshRowList: (conttext, params) => CSHRowList(),
      RouteName.cshPaging: (conttext, params) => CSHPaging(),
      RouteName.cshCycle: (conttext, params) => CSHCycle(),
      RouteName.load: (conttext, params) => MyStatefulWidget(),
      RouteName.cshTable: (conttext, params) => CSHTable(),
    };
  }
}
