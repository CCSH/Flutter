import 'package:flutter/material.dart';

class SHWidgetFixed {
  //悬浮组件key集合
  List<GlobalKey> keyList = [];
  //列表滚动方向
  Axis scrollDirection = Axis.vertical;
  //当前悬浮
  int currentIndex = -1;
  //偏移位置
  double offset = 0;
  //悬浮位置(相对于设备)
  double position = 0;
  //悬浮组件的大小
  Size _size;

  /// MARK:处理数据
  //  @LastEditors: 陈胜辉
  //  @Version: 版本号, YYYY-MM-DD
  //  @param {type}
  //  @return: 是否需要刷新
  //  @Deprecated: 否
  //  备注
  bool handleData() {
    int _currentIndex = -1;
    Offset _off = Offset(0.0, -position);
    if (scrollDirection == Axis.horizontal) {
      _off = Offset(position, 0.0);
    }

    for (var i = keyList.length - 1; i >= 0; i--) {
      GlobalKey key = keyList[i];
      if (key.currentContext != null) {
        RenderBox render = key.currentContext.findRenderObject();
        Offset renderOffset = render.localToGlobal(_off);
        //取出滚动方向对应的数据
        double location = renderOffset.dy;
        if (scrollDirection == Axis.horizontal) {
          location = renderOffset.dx;
        }

        if (location <= 0) {
          //找到最后一个悬浮的
          _currentIndex = i;
          _size = render.size;
          break;
        }
      }
    }

    //加一层复用保护
    if (_currentIndex < 0 && currentIndex >= 0) {
      GlobalKey key = keyList[currentIndex];
      if (key.currentContext == null) {
        _currentIndex = currentIndex;
      } else {
        _currentIndex = currentIndex - 1;
      }
    }

    double _offset = 0;
    //存在悬浮的
    if (_currentIndex >= 0) {
      //取出下一个位置
      if ((_currentIndex + 1) < keyList.length) {
        GlobalKey key = keyList[_currentIndex + 1];
        if (key.currentContext != null) {
          RenderBox render = key.currentContext.findRenderObject();
          Offset renderOffset = render.localToGlobal(_off);
          //取出滚动方向对应的数据
          double offsetAxis = renderOffset.dy;
          double sizeAxis = _size.height;

          if (scrollDirection == Axis.horizontal) {
            offsetAxis = renderOffset.dx;
            sizeAxis = _size.width;
          }
          //计算偏移位置
          if (offsetAxis < sizeAxis) {
            _offset = offsetAxis - sizeAxis;
          }
        }
      }
    }

    if (_currentIndex != currentIndex || _offset != offset) {
      currentIndex = _currentIndex;
      offset = _offset;
      return true;
    }

    return false;
  }
}
