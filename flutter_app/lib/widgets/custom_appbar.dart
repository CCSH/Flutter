import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/data_helper.dart';
import 'package:flutter_app/util/router.dart';
// import 'package:flutter_app/util/routerUtil.dart';

/// MARK:自定义导航栏
//  @LastEditors: 陈胜辉
//  @Version: 版本号, YYYY-MM-DD
//  @param {type}
//  @return:
//  @Deprecated: 否
//  备注
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key key,
    this.height,
    this.defaultLeft = true,
    this.opacity = 1.0,
    this.sapce = 5.0,
    this.middleText = '',
    this.middle,
    this.backgroundColor,
    this.background,
    this.actionsMaxW,
    this.leftActions,
    this.rightActions,
  })  : assert(height == null || height > CommonData.navAndStatusH,
            '导航栏高度最小为${CommonData.navAndStatusH}'),
        super(key: key);

  //高度
  final double height;
  //默认左侧按钮
  final bool defaultLeft;
  //屏幕两边空隙
  final double sapce;
  //透明度
  final double opacity;
  //标题文字
  final String middleText;
  //中间视图
  final Widget middle;
  //背景颜色
  final Color backgroundColor;
  //背景视图
  final Widget background;
  //默认 _actionW * count 如果超过需要设置
  final double actionsMaxW;
  //按钮集合
  final List<Widget> leftActions;
  final List<Widget> rightActions;

  @override
  Widget build(BuildContext context) {
    //配置视图
    return _handleWidget(context);
  }

  /// MARK:处理组件
  //  @LastEditors: 陈胜辉
  //  @Version: 版本号, YYYY-MM-DD
  //  @param {type}
  //  @return:
  //  @Deprecated: 否
  //  备注
  Widget _handleWidget(BuildContext context) {
    double _actionW = 48.0;

    //数据处理
    //背景视图
    Widget _background = this.background;
    if (_background == null) {
      _background = Container(
        color: (this.backgroundColor != null)
            ? this.backgroundColor
            : Color.fromRGBO(97, 148, 244, 1),
        child: null,
      );
    }

    //透明度（0 ～ 1）
    double _opacity = max(min(this.opacity, 1), 0);

    //事件宽度
    double _actionsMaxW = this.actionsMaxW;
    //左侧组件集合
    List<Widget> _leftActions = this.leftActions;
    //默认左侧返回按钮
    if (null == _leftActions && defaultLeft) {
      _leftActions = [_getNavBack(context)];
    }

    //取出有多少个按钮
    int count = max((_leftActions != null) ? _leftActions.length : 0,
        (this.rightActions != null) ? this.rightActions.length : 0);

    if (null == _actionsMaxW) {
      //默认
      _actionsMaxW = count * _actionW;
    }

    //中间组件
    Widget _middle = this.middle;
    if (null == _middle) {
      _middle = Container(
        alignment: Alignment.center,
        child: Text(
          middleText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      );
    }

    // 返回组件
    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: <Widget>[
          //底部背景
          Container(
            height: this.preferredSize.height,
            child: _background,
          ),

          //上方内容
          Container(
            height: CommonData.navH,
            margin: EdgeInsets.only(
              top: this.preferredSize.height - CommonData.navH,
              left: this.sapce,
              right: this.sapce,
            ),
            child: Row(
              children: <Widget>[
                //左边
                Container(
                  width: _actionsMaxW,
                  child: (null == _leftActions)
                      ? null
                      : Row(
                          children: _leftActions,
                        ),
                ),

                //中间视图
                Expanded(
                  child: _middle,
                ),

                //右边
                Container(
                  width: _actionsMaxW,
                  child: (null == rightActions)
                      ? null
                      : Row(
                          children: rightActions,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MARK:导航栏按钮
  //  @LastEditors: 陈胜辉
  //  @Version: 版本号, YYYY-MM-DD
  //  @param {type}
  //  @return:
  //  @Deprecated: 否
  //  备注
  Widget _getNavBack(BuildContext context) {
    return BackButton(
      color: Colors.white,
      onPressed: () {
        RouterUtil.pop(context);
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      max(CommonData.navAndStatusH, ((this.height == null) ? 0 : this.height)));
}
