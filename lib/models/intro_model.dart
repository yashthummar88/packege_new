class IntroModel {
  IntroModel({
    required this.imageAssetPath,
    required this.title,
    required this.desc,
  });
  late final String imageAssetPath;
  late final String title;
  late final String desc;

  IntroModel.fromJson(Map<String, dynamic> json){
    imageAssetPath = json['image_asset_path'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_asset_path'] = imageAssetPath;
    _data['title'] = title;
    _data['desc'] = desc;
    return _data;
  }
}