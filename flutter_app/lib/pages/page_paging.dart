//  @Description: 分页页面
//  @Author: 陈胜辉
//  @Date: 2019-12-23 08:39:39
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2019-12-23 16:00:40
//  @Deprecated: 否
//  备注
import 'package:flutter/material.dart';

class CSHPaging extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CSHPaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分页'),
      ),
      body: PageView.builder(
        itemBuilder: ((BuildContext context, int index) {
          return Container(
            child: Center(
              child: Text('我是第$index页'),
            ),
          );
        }),
        itemCount: 5,
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        onPageChanged: (index) {
          print('当前 $index');
        },
      ),
    );
  }
}
