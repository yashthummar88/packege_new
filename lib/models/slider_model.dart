import 'package:cloud_firestore/cloud_firestore.dart';

class SliderModel {
  SliderModel({
    required this.imageUrl,
    required this.onClickRoute,
    required this.webPageUrl,
    required this.webContent,
    required this.type,
    required this.createdOn,
    required this.index,
  });
  late final String imageUrl;
  late final String onClickRoute;
  late final String webPageUrl;
  late final String webContent;
  late final String type;
  late final Timestamp createdOn;
  late final int index;

  SliderModel.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
    onClickRoute = json['onClickRoute'];
    webPageUrl = json['webPageUrl'];
    webContent = json['webContent'];
    type = json['type'];
    createdOn = json['created_on'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['onClickRoute'] = onClickRoute;
    _data['webPageUrl'] = webPageUrl;
    _data['webContent'] = webContent;
    _data['type'] = type;
    _data['created_on'] = createdOn;
    _data['index'] = index;
    return _data;
  }
}