import 'package:flutter/material.dart';
import 'package:flutter_demo/util/http/http_request.dart';
import 'package:flutter_demo/util/http/http_config.dart';
import 'package:flutter_demo/util/http/http_model.dart';
import 'package:flutter_demo/model/newslist_model.dart';

/// MARK:
//  @Description: 类描述
//  @Author: 陈胜辉
//  @Date: 2020-12-07 09:06:15
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2020-12-07 17:26:33
//  @Deprecated: 否
//  备注
class Interface {
  // MARK 每日简报
  static Future<DataModel> bulletin({
    BuildContext context,
    Map<String, dynamic> params,
  }) async {
    // 参数处理
    Map<String, dynamic> obj = handleParams(params);
    obj.addAll({'key': '2d22b372a123d6d5ef24fa8d5fc82d83'});
    // 进行请求
    DataModel model = await Request.of(
      context: context,
      request: RequestType.Request_get,
    ).request(
      Api.bulletin,
      params: obj,
    );
    //成功处理解析数据
    if (model.code == StatusCode.success) {
      // 处理数据
      List<NewsListModel> list;
      for (Map<String, dynamic> map in model.data) {
        list.add(NewsListModel.fromJson(map));
      }
      // 赋值
      model.data = list;

      return model;
    }

    // TODO 对于此接口公共处理在这里

    print('数据处理完毕');
    print(model);
    // XXX 或者返回空或其他
    return model;
  }

  static Map handleParams(Map params) {
    return (params ?? new Map<String, dynamic>());
  }
}
