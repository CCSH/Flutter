//状态模型类
import 'package:dio/dio.dart';

// 自定义拦截器拦截处理
// 接口返回数据模型
class ResultModel {
  // 状态码
  final ResultCode code;
  // 成功加载数据
  final Map<dynamic, dynamic> data;

  ResultModel(this.code, this.data);
}

// 根据返回封装的数据模型
class DataModel {
  final int code;
  final String msg;
  dynamic data;

  DataModel({
    this.code,
    this.msg,
    this.data,
  });

  //TODO 工厂方法JSON转换模型对象
  factory DataModel.fromJson(Map<dynamic, dynamic> json) {
    return DataModel(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}

//所有接口 存在处理行为分类
// 状态码类型
enum ResultCode {
  success, //成功
  error, //服务器错误
  fail, //请求失败
  login, //登陆错误
}

//所有接口
// 状态码
class StatusCode {
  //正常返回
  static const success = 200;
  //内部服务器错误
  static const error = 100;
  // 接口暂时关闭维护中
  static const close = 110;
  // IP请求来源受限
  static const limited = 120;
  // API调用频率超限
  static const frequency = 130;

  /* ----- 业务错误码 ----- */
  // key错误或为空
  static const key_error = 230;
  // 缺少key参数
  static const key_no = 240;
}
