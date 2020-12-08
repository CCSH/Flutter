// 环境
enum _Env {
  //开发
  dev,
  //测试
  test,
  //发布
  production,
  //自定义
  custom,
}

// 整体环境
mixin _Server_env {
  //切换环境 设置这里
  static const _Env type = _Env.dev;
}

// 主机地址
mixin _Server_host {
  static const custom = dev;

  static const dev = 'http://api.tianapi.com/';
  static const test = 'http://api.tianapi.com/';
  static const production = 'http://api.tianapi.com/';
}

// H5地址
mixin _Server_h5 {
  static const custom = dev;

  static const dev = 'http://192.168.1.1';
  static const test = 'http://h5test.ccsh.com/';
  static const production = 'http://h5pro.ccsh.com/';
}

class Config {
  //超时
  static const timeOut = 15000;

  //获取主机地址
  static String getHost() {
    switch (_Server_env.type) {
      case _Env.dev:
        return _Server_host.dev;
      case _Env.test:
        return _Server_host.test;
      case _Env.production:
        return _Server_host.production;
      default:
        //默认自定义环境
        return _Server_host.custom;
    }
  }

  //获取H5主机地址
  static String getH5() {
    switch (_Server_env.type) {
      case _Env.dev:
        return _Server_h5.dev;
      case _Env.test:
        return _Server_h5.test;
      case _Env.production:
        return _Server_h5.production;
      default:
        //默认自定义环境
        return _Server_h5.custom;
    }
  }
}

class Api {
  // 每日简报
  static const String bulletin = 'bulletin/index';
}
