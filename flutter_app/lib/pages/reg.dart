import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:async';

import 'package:flutter_app/util/helper_focus.dart';
import 'package:flutter_app/util/helper_time.dart';
import 'package:flutter_app/util/router.dart';
import 'package:flutter_app/util/toast_util.dart';
import 'package:flutter_app/util/helper_tool.dart';

enum TextFieldType {
  phone,
  code,
  password,
}

class RegPage extends StatefulWidget {
  final param;
  RegPage({
    Key key,
    this.param,
  }) : super(key: key);

  @override
  _RegPage createState() => _RegPage();
}

class _RegPage extends State<RegPage> {
  bool isAppear = false;
  //输入框显示内容
  TextEditingController phoneTextC = TextEditingController();
  TextEditingController codeTextC = TextEditingController();
  TextEditingController passwordTextC = TextEditingController();
  //密码显隐
  bool isLook = false;
  //选中协议
  bool isAgreed = true;
  //倒计时数值
  var currentTime = 0;
  //定时器
  Timer timer;
  //焦点集合
  Map focusNodeMap = Map();

  @override
  void initState() {
    super.initState();
    if (widget.param != null) {
      showToast('参数来了 ===' + widget.param['param']);
    }
  }

  @override
  void didChangeDependencies() {
    bool current = ModalRoute.of(context).isCurrent;
    if (current && !isAppear) {
      isAppear = true;
      print('界面将要出现！！！！');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isAppear = false;
    //配置UI
    return congifUI(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  //释放定时器
  @override
  void dispose() {
    timer?.cancel();
    currentTime = 0;
    super.dispose();
  }

  //MARK: - 组件
  /* MARK: 配置UI
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  GestureDetector congifUI(BuildContext context) {
    return GestureDetector(
      onTap: actionTouchBegin,
      child: Theme(
        data: ThemeData(
          //去除水波纹
          splashColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          //导航栏
          appBar: configAppBar(),
          //内容
          body: congifBody(context),
        ),
      ),
    );
  }

  /* MARK:配置appBar
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  PreferredSize configAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: AppBar(
        backgroundColor: Colors.white,
        //隐藏线
        elevation: 0,
        //状态栏颜色
        brightness: Brightness.dark,
        //返回按钮
        leading: GestureDetector(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 30,
          ),
          onTap: actionBackPage,
        ),
        //右侧按钮
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15),
            // alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                '登录',
                style: TextStyle(
                  fontSize: 14.5,
                  color: Color.fromRGBO(54, 90, 247, 1),
                ),
              ),
              onTap: actionGotoRegPage,
            ),
          )
        ],
      ),
    );
  }

  /* MARK:配置内容
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  SingleChildScrollView congifBody(BuildContext context) {
    //屏幕size
    final size = MediaQuery.of(context).size;
    //状态栏高度
    final double statusH = MediaQueryData.fromWindow(window).padding.top;
    //底部安全区域
    final double bottomH = MediaQueryData.fromWindow(window).padding.bottom;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 13, 20, 30),
        constraints: BoxConstraints(
          maxHeight: size.height - statusH - 44.0 - bottomH,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  //注册
                  configTitle(),

                  //手机号输入框
                  configInput(TextFieldType.phone),

                  //验证码输入框
                  configInput(TextFieldType.code),

                  //密码输入框
                  configInput(TextFieldType.password),

                  //注册按钮
                  configRegistered(),

                  //协议
                  configXieYi(),
                ],
              ),
            ),
            //版本号
            getVersion(),
          ],
        ),
      ),
    );
  }

  /* MARK:注册Text
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container configTitle() {
    var textStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
      color: const Color.fromRGBO(51, 51, 51, 1),
    );

    return Container(
      child: Text(
        "注册",
        style: textStyle,
      ),
      alignment: Alignment.centerLeft,
    );
  }

  /* MARK:配置输入框
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container configInput(TextFieldType type) {
    Widget rightView = Container();

    switch (type) {
      case TextFieldType.code:
        rightView = getCode();
        break;
      case TextFieldType.password:
        rightView = getLook();
        break;
      default:
    }
    return Container(
      margin: EdgeInsets.only(
        top: type == TextFieldType.phone ? 55 : 25,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: getTextField(type),
              ),
              rightView,
            ],
          ),
          getLine(),
        ],
      ),
    );
  }

  /* MARK:获取输入框
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container getTextField(TextFieldType type) {
    var hintText = '请输入有效11位手机号';
    var labelText = '手机号';
    TextEditingController controller = phoneTextC;
    List<TextInputFormatter> inputFormatters = [
      WhitelistingTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(11),
    ];

    switch (type) {
      case TextFieldType.code:
        hintText = '请输入短信验证码';
        labelText = '验证码';
        controller = codeTextC;
        inputFormatters = [
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ];
        break;
      case TextFieldType.password:
        hintText = '请设置6-16位字母与数字的组合密码';
        labelText = '登录密码';
        controller = passwordTextC;
        inputFormatters = [
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ];
        break;
      default:
    }

    if (controller.text.length == 0) {
      labelText = '';
    }

    /* MARK:焦点
     * @LastEditors: 陈胜辉
     * @Version: 版本号, YYYY-MM-DD
     * @param {type} 
     * @return: 
     * @Deprecated: 否
     */
    if (!focusNodeMap.containsKey(type)) {
      focusNodeMap[type] = shFocusNode((FocusNode focusNode) {
        setState(() {});
      });
    }

    bool isClear = false;
    FocusNode focusNode = focusNodeMap[type];
    if (focusNode.hasFocus && controller.text.length > 0) {
      isClear = true;
    }

    return Container(
      height: 46,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color.fromRGBO(208, 208, 208, 1),
                fontSize: 17,
              ),
              labelStyle: TextStyle(
                color: Color.fromRGBO(173, 173, 173, 1),
                fontSize: 12,
              ),
              border: InputBorder.none,
              // suffixIcon: isClear
              //     ? IconButton(
              //         icon: Image.asset(
              //           "assets/image/ic_clear.png",
              //           width: 15,
              //           height: 15,
              //         ),
              //         onPressed: () {
              //           controller.clear();
              //           setState(() {});
              //         },
              //       )
              //     : SizedBox(),
            ),
            //输入框样式
            style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontSize: 17,
            ),
            onChanged: (text) {
              //TODO 手机号的话需要格式化一下
              //刷新
              setState(() {});
            },
            focusNode: focusNode,
            autofocus: false,
            obscureText: (type == TextFieldType.password) && !isLook,
            keyboardType: (type != TextFieldType.password)
                ? TextInputType.number
                : TextInputType.text,
            controller: controller,
            inputFormatters: inputFormatters,
          ),
          Positioned(
            top: -7,
            child: Text(
              labelText,
              style: TextStyle(
                color: Color.fromRGBO(173, 173, 173, 1),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* MARK:验证码
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  GestureDetector getCode() {
    var str = '获取验证码';

    if (currentTime > 0) {
      str = '重新发送(' + currentTime.toString() + ')';
    }

    return GestureDetector(
      onTap: (currentTime > 0) ? null : actionStartTime,
      child: Container(
        child: Text(
          str,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Helvetica Neue',
            color: (currentTime > 0)
                ? Color.fromRGBO(173, 173, 173, 1)
                : Color.fromRGBO(255, 114, 19, 1),
          ),
        ),
      ),
    );
  }

  /* MARK:密码显隐
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container getLook() {
    return Container(
      // child: IconButton(
      //   icon: Image.asset(isLook
      //       ? 'assets/image/pwd_look.png'
      //       : 'assets/image/pwd_un_look.png'),
      //   onPressed: actionLook,
      //   padding: EdgeInsets.only(right: 0),
      // ),
      width: 20,
    );
  }

  /* MARK:分割线
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container getLine() {
    return Container(
      color: Color.fromRGBO(234, 234, 234, 1),
      height: 0.5,
    );
  }

  /* MARK:注册按钮
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  GestureDetector configRegistered() {
    bool isSelect = true;
    if (!(phoneTextC.text.length > 0 &&
        codeTextC.text.length > 0 &&
        passwordTextC.text.length > 0 &&
        isAgreed)) {
      isSelect = false;
    }

    return GestureDetector(
      child: Container(
        child: Text(
          '注册',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        margin: EdgeInsets.only(top: 36),
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          //背景
          color: isSelect
              ? Color.fromRGBO(54, 90, 247, 1)
              : Color.fromRGBO(182, 195, 255, 1),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(22.5)),
        ),
      ),
      onTap: isSelect ? actionRegister : null,
    );
  }

  /* MARK:协议
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container configXieYi() {
    return Container(
      margin: EdgeInsets.only(top: 17),
      child: Row(
        children: <Widget>[
          //选择框
          GestureDetector(
            child: Container(
              // child: isAgreed
              //     ? Image.asset('assets/image/icon_select.png')
              //     : Image.asset('assets/image/icon_un_select.png'),
              width: 17,
              height: 17,
            ),
            onTap: actionAgreed,
          ),

          //文本
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 20),
              child: RichText(
                text: TextSpan(
                  text: '点击注册，即表示您同意',
                  style: TextStyle(
                    color: Color.fromRGBO(154, 154, 154, 1),
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '《服务协议》',
                      style: TextStyle(
                        color: Color.fromRGBO(54, 90, 247, 1),
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = actionXieYi,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* MARK:版本号
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  Container getVersion() {
    return Container(
      child: Text(
        '当前版本:' + '1.0',
        style: TextStyle(
          color: Color.fromRGBO(199, 199, 199, 1),
          fontSize: 13,
        ),
      ),
      alignment: Alignment.center,
    );
  }

  //MARK: - 方法
  /* MARK:点击空白
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionTouchBegin() {
    print('点击空白');
    //关闭键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /* MARK:返回上一页面
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionBackPage() {
    print('返回上一页面');
    actionTouchBegin();

    RouterUtil.pop(
      context,
      params: '我回来啦！！！',
    );

    // RouterUtil.popToRouter(
    //   context,
    //   '/',
    // );
  }

  /* MARK:进入登录页面
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionGotoRegPage() {
    print('进入登录页面');
    actionTouchBegin();
    RouterUtil.navigateTo(
      context,
      RouteName.root,
    );
  }

  /* MARK:密码显隐
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionLook() {
    print('点击密码显隐');
    setState(() {
      isLook = !isLook;
    });
  }

  /* MARK:获��验证码
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionCode() {
    print('获取验证码');
    setState(() {
      isLook = !isLook;
    });
  }

  /* MARK:开始倒计时
   * @LastEditors: 陈���辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionStartTime() {
    timer = startCountdown(60, (obj, time) {
      setState(() {
        currentTime = time;
      });
    });
  }

  /* MARK:注册点击
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionRegister() {
    print('点击了注册');
  }

  /* MARK:同意点击
   * @LastEditors: 陈胜辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionAgreed() {
    setState(() {
      isAgreed = !isAgreed;
    });
  }

  /* MARK:协议点击
   * @LastEditors: 陈��辉
   * @Version: 版本号, YYYY-MM-DD
   * @param {type} 
   * @return: 
   * @Deprecated: 否
   */
  void actionXieYi() {
    print('点击了协议');
  }
}
