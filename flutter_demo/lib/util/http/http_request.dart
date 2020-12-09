// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/util/http/http_config.dart';
import 'package:flutter_demo/util/http/http_model.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:flutter_demo/util/toast_util.dart';
import 'dart:convert' as convert;

//请求类型
enum RequestType {
  Request_get,
  Request_post,
}

// 请求
class Request {
  BuildContext _context;
  // 请求类型
  RequestType _request;
  // 单例dio
  Dio _dio;
  // 单例对象
  static Request _instance;

  BaseOptions options = BaseOptions(
    baseUrl: Config.getHost(),
    contentType: Headers.jsonContentType,
    responseType: ResponseType.plain,
    // receiveTimeout: 3000,
    // connectTimeout: Config.timeOut,
    // extra: {
    //   'api': '1.0.0',
    // },
  );

  // MARK 单例初始化方法
  Request._internal() {
    if (null == _dio) {
      _dio = Dio(options);

      // 添加拦截器
      _dio.interceptors.add(InterceptorsWrapper(
        //请求开始
        onRequest: (RequestOptions options) {
          return options;
        },
        //响应开始
        onResponse: (Response response) {
          var data = response.data;
          // 转map
          Map map = convert.jsonDecode(data);
          // 数据解析
          DataModel model = DataModel.fromJson(map);
          switch (model.result) {
            //成功
            case StatusCode.success:
              break;
            //服务器内部错误
            case StatusCode.error:
              // return _dio.reject('服务器错误');
              break;
            //登陆错误
            case StatusCode.login:
              // toast接口返回登录拦截提示
              showToast(model.msg);
              // 跳转到登录页面
              RouterUtil.navigateTo(_context, RouteName.login);
              break;
            default:
              //服务器返回错误
              showToast(model.msg);
              break;
          }
          //返回数据
          return _dio.resolve(model);
        },
        //错误
        onError: (DioError e) {
          showToast('请检查网络');
          return e;
        },
      ));

      //日志打印
      _dio.interceptors.add(LogInterceptor(responseBody: false));
    }
  }

  // MARK 设置BuildContext
  _setConext(BuildContext context) {
    _context = context;
  }

  // MARK 单例设置BuildContext
  static Request of({
    BuildContext context,
    RequestType request,
  }) {
    _instance = _instance ?? Request._internal();

    // 下方为可选参数
    // 请求类型 默认get
    _instance._request = request ?? RequestType.Request_get;
    if (context != null) {
      _instance._setConext(context);
    }
    return _instance;
  }

  // MARK 请求
  Future<DataModel> request(String url, {Map<String, dynamic> params}) async {
    //可以更改一些配置
    // BaseOptions options = _dio.options;
    // _dio.options = options;
    Response res;
    switch (_request) {
      //POST请求
      case RequestType.Request_post:
        res = await _dio.post(url, data: params);
        break;
      default:
        //默认 GET请求
        res = await _dio.get(url, queryParameters: params);
    }

    return res.data;
  }
}
