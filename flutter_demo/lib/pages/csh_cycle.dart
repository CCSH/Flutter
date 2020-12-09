// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/custom_appbar.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:flutter_demo/util/toast_util.dart';

class CSHCycle extends StatefulWidget {
  @override
  _CSHCycleState createState() => _CSHCycleState();
}

class _CSHCycleState extends State<CSHCycle> {
  bool isAppear = false;
  @override
  void didChangeDependencies() {
    bool current = ModalRoute.of(context).isCurrent;
    if (current && isAppear == false) {
      isAppear = true;
      showToast('界面将要出现');
      setState(() {});
    }
    super.didChangeDependencies();
  }

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
  Widget build(BuildContext context) {
    isAppear = false;
    return Scaffold(
      appBar: CustomAppBar(
        middleText: '界面周期',
      ),
      body: WillPopScope(
          onWillPop: () {
            showToast('界面将要退出');
            return Future.value(true);
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: MaterialButton(
                      child: Text('跳转'),
                      onPressed: () {
                        RouterUtil.navigateTo(context, RouteName.cshQr);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
