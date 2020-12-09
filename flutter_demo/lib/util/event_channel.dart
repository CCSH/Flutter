// @dart=2.9
import 'package:flutter/services.dart';
import 'package:flutter_demo/util/toast_util.dart';

class ChannelName {
  //推送监听
  static const String push = 'app/event_channel/push';
}

typedef _CallBack = void Function(String message);

// MARK 推送监听
EventChannel listenPush(_CallBack callback) {
  //持续通信
  EventChannel eventChannel = EventChannel(ChannelName.push);
  eventChannel.receiveBroadcastStream('发送参数').listen((Object message) {
    callback(message);
  }, onError: (Object error) {
    showToast('推送监听出错');
  });

  return eventChannel;
}
