import 'package:json_annotation/json_annotation.dart';
part 'homelist_model.g.dart';

// //一次
// flutter pub run build_runner build
// //监听
// flutter packages pub run build_runner watch
@JsonSerializable()
class HomeListModel {
  String goods_id;
  String goods_name;
  String shop_price;
  String original_img;
  String sales_sum;
  String discount;
  String price;

  HomeListModel({
    this.goods_id,
    this.goods_name,
    this.shop_price,
    this.original_img,
    this.sales_sum,
    this.discount,
    this.price,
  });

  //反序列化
  factory HomeListModel.fromJson(Map<String, dynamic> map) {
    return _$HomeListModelFromJson(map);
  }

  //序列化
  Map<String, dynamic> toJson() {
    return _$HomeListModelToJson(this);
  }
}
