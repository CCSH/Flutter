import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';

// MARK view类型
class PlatformViewType {
  // 文字
  static String label = '/plugins/platform_view/label';
}

//回调方法
typedef void PlatformCallback(CallBack callback);

// MARK 回调
class CallBack {
  static MethodChannel _channel;
  //类型
  static String type;

  CallBack._({int id}) {
    _channel = MethodChannel(type + '_$id');
  }

  // MARK 调用方法
  //刷新方法
  reloadView() {
    _channel.invokeMethod('reloadView', '刷新');
  }

  //版本
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

// MARK 原生平台视图
class PlatformView extends StatefulWidget {
  final PlatformCallback callBack;
  //view类型
  final String type;

  const PlatformView({
    Key key,
    this.type,
    this.callBack,
  }) : super(key: key);
  @override
  _PlatformViewState createState() => _PlatformViewState();
}

class _PlatformViewState extends State<PlatformView> {
  @override
  Widget build(BuildContext context) {
    return _handelView();
  }

  // MARk 处理视图
  Widget _handelView() {
    Widget view;
    if (widget.type == PlatformViewType.label) {
      //文本
      view = _label();
    }

    if (view != null) {
      return view;
    } else {
      return Container(
        child: Text('当钱平台原生组件不支持！！！'),
      );
    }
  }

  // MARK 文本
  Widget _label() {
    if (Platform.isIOS) {
      //ios 原生界面
      return UiKitView(
        viewType: widget.type,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{"type": widget.type.split('/').last},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return null;
  }

  void _onPlatformViewCreated(id) {
    if (widget.callBack == null) {
      return;
    }
    widget.callBack(CallBack._(id: id));
  }
}
