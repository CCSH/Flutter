// @dart=2.9
import 'package:flutter/material.dart';

extension SHExtension on GlobalKey {
  static Offset offset = Offset.zero;

  void setOffset(Offset off) {
    offset = off;
  }

  RenderBox _render() {
    if (this.currentContext != null) {
      return this.currentContext.findRenderObject();
    }
    return null;
  }

  double x() {
    return this.origin().dx;
  }

  double y() {
    return this.origin().dy;
  }

  double width() {
    return this.size().width;
  }

  double height() {
    return this.size().height;
  }

  Offset origin() {
    return this._render().localToGlobal(offset);
  }

  Size size() {
    return this._render().size;
  }

  double maxX() {
    return this.x() + this.width();
  }

  double maxY() {
    return this.y() + this.height();
  }

  double centerX() {
    return this.x() + (this.width() / 2);
  }

  double centerY() {
    return this.y() + (this.height() / 2);
  }

  String debugLabel() {
    String temp = this.toString();
    if (temp.contains(' ')) {
      List list = temp.split(' ');
      String str = list.last;
      return str.split(']').first;
    }
    return '';
  }
}
