import 'package:shared_preferences/shared_preferences.dart';

/// MARK:存储
//  @Description: 类描述
//  @Author: 陈胜辉
//  @Date: 2020-12-11 10:16:47
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2020-12-11 10:16:47
//  @Deprecated: 否
//  备注
class Save {
  // MARK 保存数据
  Future<bool> setData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      //数据为空删除key
      return prefs.remove(key);
    }
    return prefs.setString(key, value);
  }

  // MARK 获取数据
  Future<String> getDataWithKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key);
    if (value == null) {
      value = '';
    }
    return value;
  }

  // MARK 是否含有key
  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // MARK 清楚所有key
  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // MARK 打印所有数据
  printfKeys() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
  }
}
