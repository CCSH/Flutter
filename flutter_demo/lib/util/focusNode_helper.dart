/* 
 * @Description: 焦点帮助类
 * @Author: 陈胜辉
 * @Date: 2019-11-18 17:22:05
 * @Version: 版本号, YYYY-MM-DD
 * @LastEditors: 陈胜辉
 * @LastEditTime: 2019-11-20 13:29:54
 * @Deprecated: 否
 */

import 'package:flutter/material.dart';

typedef _CallBack = void Function(FocusNode focusNode);

/* MARK: 焦点处理
 * @LastEditors: 陈胜辉
 * @Version: 版本号, YYYY-MM-DD
 * @param {
 *  callback 回调
 * } 
 * @return: 
 * @Deprecated: 否
 */
FocusNode shFocusNode(_CallBack callback) {
  FocusNode focusNode = FocusNode();
  focusNode.addListener(() {
    callback(focusNode);
  });

  return focusNode;
}
