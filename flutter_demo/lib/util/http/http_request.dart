import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/util/http/http_config.dart';
import 'package:flutter_demo/util/http/http_model.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:flutter_demo/util/toast_util.dart';

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
    responseType: ResponseType.json,
    receiveTimeout: 3000,
    connectTimeout: Config.timeOut,
    // headers: {
    //   'api': '1.0.0',
    // },
  );

  // MARK 单例初始化方法
  Request._internal() {
    if (null == _dio) {
      _dio = Dio(options);

      // 加载日志拦截器功能
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print(
              "\n================================= 接口请求 开始 =================================");
          print("请求baseUrl：${options.baseUrl}");
          print("请求url：${options.path}");
          print("请求头: " + options.headers.toString());
          print("请求方式: " + options.method.toString());
          if (options.data != null) {
            print('请求data参数: ' + options.data.toString());
          }
          if (options.queryParameters != null) {
            print('请求queryParameters参数: ' + options.queryParameters.toString());
          }
          print(
              "================================= 接口请求 结束 =================================");
        },
        onResponse: (Response response) {
          print(
              "\n================================= 响应数据开始 =================================");
          print("url = ${response.realUri}");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print(
              "================================= 响应数据结束 =================================");
        },
        onError: (DioError e) {
          print(
              "\n=============================== 错误响应数据 =================================");
          print("请求异常: " + e.toString());
          print("请求异常信息: " + e.response?.toString() ?? "");
        },
      ));

      // 加载响应拦截器功能开发
      _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError err) async {
          return ResultModel(
            ResultCode.fail,
            null,
          );
        },
        onResponse: (Response response) async {
          // 如果接口响应成功
          int code = response.data['code'];
          switch (code) {
            //请求成功
            case StatusCode.success:
              return ResultModel(
                ResultCode.success,
                response.data,
              );
              break;
            //登陆错误
            case StatusCode.key_error:
            case StatusCode.key_no:
              return ResultModel(
                ResultCode.login,
                response.data,
              );
              break;
            default:
              //服务器失败
              return ResultModel(
                ResultCode.error,
                response.data,
              );
          }
        },
      ));
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
        res = await _dio.post(url, queryParameters: params);
        break;
      default:
        //默认 GET请求
        res = await _dio.get(url, queryParameters: params);
    }
    //处理接口回参 统一处理行为
    return _handleResultData(res.data);
  }

  // MARK 所有接口都有的行为在这里进行处理
  DataModel _handleResultData(ResultModel model) {
    //转换
    DataModel data = DataModel.fromJson(model.data);
    //接口回参统一处理
    switch (model.code) {
      // 登录拦截
      case ResultCode.login:
        // toast接口返回登录拦截提示
        showToast(data.msg);
        // 模拟跳转到登录
        RouterUtil.navigateTo(_context, RouteName.login);
        return null;
        break;
      // 网络请求失败
      case ResultCode.fail:
        showToast('请检查网络');
        break;
      default:
        break;
    }
    //其他 抛给 UI层 或者 接口层 处理
    return data;
  }
}
