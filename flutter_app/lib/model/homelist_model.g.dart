// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homelist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListModel _$HomeListModelFromJson(Map<String, dynamic> json) {
  return HomeListModel(
    goods_id: json['goods_id'] as String,
    goods_name: json['goods_name'] as String,
    shop_price: json['shop_price'] as String,
    original_img: json['original_img'] as String,
    sales_sum: json['sales_sum'] as String,
    discount: json['discount'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$HomeListModelToJson(HomeListModel instance) =>
    <String, dynamic>{
      'goods_id': instance.goods_id,
      'goods_name': instance.goods_name,
      'shop_price': instance.shop_price,
      'original_img': instance.original_img,
      'sales_sum': instance.sales_sum,
      'discount': instance.discount,
      'price': instance.price,
    };
