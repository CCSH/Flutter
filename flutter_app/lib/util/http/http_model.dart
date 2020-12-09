//状态模型类
import 'package:dio/dio.dart';

// 根据返回封装的数据模型
class DataModel {
  final String result;
  final String msg;
  dynamic data;

  DataModel({
    this.result,
    this.msg,
    this.data,
  });

  //TODO 工厂方法JSON转换模型对象
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      result: json['result'],
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
  static const success = '0';
  //内部服务器错误(数据库异常、等)
  static const error = '100';

  /* ----- 业务错误码 ----- */
  //没数据
  static const no_data = '2';
  // key错误或为空
  static const key_error = '230';
  // 缺少key参数
  static const key_no = '240';
  //用户未登录
  static const login = '250';
}
