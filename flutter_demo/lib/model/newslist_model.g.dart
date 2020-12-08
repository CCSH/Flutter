// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newslist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsListModel _$NewsListModelFromJson(Map<String, dynamic> json) {
  return NewsListModel(
    mtime: json['mtime'] as String,
    title: json['title'] as String,
    digest: json['digest'] as String,
    imgsrc: json['imgsrc'] as String,
    url: json['url'] as String,
    source: json['source'] as String,
  );
}

Map<String, dynamic> _$NewsListModelToJson(NewsListModel instance) =>
    <String, dynamic>{
      'mtime': instance.mtime,
      'title': instance.title,
      'digest': instance.digest,
      'imgsrc': instance.imgsrc,
      'url': instance.url,
      'source': instance.source,
    };
