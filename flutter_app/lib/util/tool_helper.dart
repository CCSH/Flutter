/// MARK:
//  @Description: 类描述
//  @Author: 陈胜辉
//  @Date: 2020-12-09 11:22:24
//  @Version: 版本号, YYYY-MM-DD
//  @LastEditors: 陈胜辉
//  @LastEditTime: 2020-12-09 11:28:10
//  @Deprecated: 否
//  备注
class Tool {
  //获取资源图片
  static String getImage(String name) {
    String temp = 'assets/image/';
    //补全路径
    if (!name.contains(temp)) {
      temp = 'assets/image/$name';
    }
    //补全类型
    if (!temp.contains('png')) {
      temp = '$temp.png';
    }
    return temp;
  }
}
