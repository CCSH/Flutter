//  @Description: Color拓展
//  @Author: 陈胜辉
//  @Date: 2019-12-18 09:54:38
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2019-12-18 13:06:53
//  @Deprecated: 否
//  备注
import 'package:flutter/material.dart';

extension SHExtension on Color {
  //color 转 16进制string
  String toHex() {
    List temp = [this.alpha, this.red, this.green, this.blue];
    String color = '#';
    for (var obj in temp) {
      String str = obj.toRadixString(16);
      color += str;
    }
    return color.toUpperCase();
  }
}
