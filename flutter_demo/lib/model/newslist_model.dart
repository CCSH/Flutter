import 'package:json_annotation/json_annotation.dart';
part 'newslist_model.g.dart';

// //一次
// flutter pub run build_runner build
// //监听
// flutter packages pub run build_runner watch
@JsonSerializable()
class NewsListModel {
  String mtime;
  String title;
  String digest;
  String imgsrc;
  String url;
  String source;

  NewsListModel({
    this.mtime,
    this.title,
    this.digest,
    this.imgsrc,
    this.url,
    this.source,
  });

  //反序列化
  factory NewsListModel.fromJson(Map<String, dynamic> json) {
    return _$NewsListModelFromJson(json);
  }

  //序列化
  Map<String, dynamic> toJson() {
    return _$NewsListModelToJson(this);
  }
}
