import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/widget_appbar.dart';
import 'package:flutter_app/util/router.dart';
import 'package:flutter_app/util/toast_util.dart';

class CSHCycle extends StatefulWidget {
  @override
  _CSHCycleState createState() => _CSHCycleState();
}

class _CSHCycleState extends State<CSHCycle> {
  bool isAppear = false;
  @override
  void didChangeDependencies() {
    showToast('界面将要出现');
    super.didChangeDependencies();
    // //添加监听
    // Main.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  // @override
  // void didPopNext() {
  //   // Covering route was popped off the navigator.
  //   print('返回NewView');
  // }

  // @override
  // void didPush() {
  //   // Route was pushed onto navigator and is now topmost route.
  //   print('进入NewView');
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration dur) {
      showToast('界面绘制完毕');
    });
    super.initState();
  }

  @override
  void dispose() {
    showToast('界面销毁');
    super.dispose();
  }

  @override
  void deactivate() {
    showToast('界面将要销毁');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    isAppear = false;
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '界面周期',
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  child: Text('跳转'),
                  onPressed: () {
                    RouterUtil.push(context, RouteName.rowList);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
