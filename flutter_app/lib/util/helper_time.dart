/*
 * @Description: 时间帮助类
 * @Author: 陈胜辉
 * @Date: 2019-11-20 10:09:31
 * @Version: 版本号, YYYY-MM-DD
 * @LastEditors: 陈胜辉
 * @LastEditTime: 2019-11-20 11:14:45
 * @Deprecated: 否
 */
import 'dart:async';

typedef _CallBack = void Function(Timer timer, int currentTime);

/* MARK: 倒计时方法
 * @LastEditors: 陈胜辉
 * @Version: 版本号, YYYY-MM-DD
 * @param { 
 *  maxTime 最大时间
 *  callback 回调(timer 定时器，currentTime 当前时间)
 * } 
 * @return: 定时器
 * @Deprecated: 否
 */
Timer startCountdown(int maxTime, _CallBack callback) {
  var currentTime = maxTime;
  Timer timer = Timer.periodic(Duration(seconds: 1), (obj) {
    currentTime--;

    if (currentTime < 1) {
      obj.cancel();
      currentTime = 0;
    }
    callback(obj, currentTime);
  });

  //马上运行一次
  callback(timer, currentTime);

  return timer;
}
