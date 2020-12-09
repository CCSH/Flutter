import 'package:flutter/material.dart';
import 'package:flutter_app/util/http/http_request.dart';
import 'package:flutter_app/util/http/http_config.dart';
import 'package:flutter_app/util/http/http_model.dart';
import 'package:flutter_app/model/homelist_model.dart';

class Interface {
  // MARK 处理参数
  static Map handleParams(Map params) {
    Map<String, dynamic> data = (params ?? new Map<String, dynamic>());
    data.addAll({'flag': 'weixin'});
    return data;
  }

  // MARK 首页
  static Future<DataModel> homeList({
    BuildContext context,
    //这里也可以把参数一个一个列举出来
    Map<String, dynamic> params,
  }) async {
    // 参数处理
    Map data = handleParams(params);
    // 进行请求
    DataModel model = await Request.of().request(
      Api.WechatIndex,
      params: data,
    );

    //成功处理解析数据
    if (model.result == StatusCode.success) {
      // 处理数据
      List<HomeListModel> list = List();
      for (Map<String, dynamic> map in model.data) {
        HomeListModel obj = HomeListModel.fromJson(map);
        list.addAll([obj]);
      }
      // 赋值
      model.data = list;
    }
    return model;
  }
}
