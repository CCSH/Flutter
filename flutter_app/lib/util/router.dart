import 'package:flutter_app/extension/sh_extension_string.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app/pages/page_android.dart';
import 'package:flutter_app/pages/page_animated.dart';
import 'package:flutter_app/pages/page_column_list.dart';
import 'package:flutter_app/pages/page_cycle.dart';
import 'package:flutter_app/pages/page_nav.dart';
import 'package:flutter_app/pages/page_paging.dart';
import 'package:flutter_app/pages/page_row_list.dart';
import 'package:flutter_app/pages/page_table.dart';
import 'package:flutter_app/pages/page_home.dart';
import 'package:flutter_app/pages/page_ios.dart';
import 'package:flutter_app/pages/page_load.dart';
import 'package:flutter_app/pages/page_storage.dart';
import 'package:flutter_app/pages/page_reg.dart';
import 'package:flutter_app/pages/root.dart';
import 'dart:convert' as convert;
import 'package:flutter_app/util/toast_util.dart';

typedef _CallBack = void Function(dynamic result);

class RouterUtil {
  //路由参数
  static const String _param = 'router_param';

  // MARK 跳转到指定页面
  static push(BuildContext context, String url,
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

  // MARK 返回页面
  static pop(BuildContext context, {dynamic params, bool root}) {
    //返回上一页
    Navigator.maybePop(context, params);
  }

  // MARK 返回跟页面
  static popRoot(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(RouteName.root));
  }

  // MARK 是否可以返回
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
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
  static String root = '/';
  // 主页
  static String home = '/home';
  // ios
  static String ios = '/ios';
  // 安卓
  static String android = '/android';

  // 注册
  static String reg = '/reg';
  // 界面周期
  static String page = '/page';
  // 导航栏
  static String nav = '/nav';
  // 布局
  static String layout = '/layout';
  // 动画
  static String animated = '/animated';
  // 列
  static String columnList = '/column_list';
  // 行
  static String rowList = '/row_list';
  // 表格
  static String table = '/table';
  // 分页
  static String paging = '/paging';
  // 界面周期
  static String cycle = '/cycle';
  // 加载
  static String load = '/load';
  // 存储
  static String storage = '/storage';
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
      RouteName.root: (context, params) {
        return RootPage();
      },
      RouteName.home: (context, params) => HomePage(),
      RouteName.ios: (context, params) => IOSPage(),
      RouteName.android: (context, params) => AndroidPage(),
      RouteName.reg: (context, params) {
        Map param = RouterUtil.getRouterParams(params);
        return RegPage(
          param: param,
        );
      },
      RouteName.nav: (context, params) => CSHNav(),
      RouteName.animated: (conttext, params) => AnimatedListSample(),
      RouteName.columnList: (conttext, params) => CSHColumnList(),
      RouteName.rowList: (conttext, params) => CSHRowList(),
      RouteName.paging: (conttext, params) => CSHPaging(),
      RouteName.cycle: (conttext, params) => CSHCycle(),
      RouteName.load: (conttext, params) => MyStatefulWidget(),
      RouteName.table: (conttext, params) => CSHTable(),
      RouteName.storage: (conttext, params) => CounterWidget(),
    };
  }
}
