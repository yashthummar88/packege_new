import 'package:firebase_database/firebase_database.dart';

class AdsModel {
  AdsModel({
    required this.title,
    required this.des,
    required this.image,
    required this.page,
    required this.url,
    required this.parentCode,
  });
  late final String title;
  late final String des;
  late final String image;
  late final String page;
  late final String url;
  late final String parentCode;

  AdsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    des = json['des'];
    image = json['image'];
    page = json['page'];
    url = json['url'];
    parentCode = json['parent_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['des'] = des;
    _data['image'] = image;
    _data['page'] = page;
    _data['url'] = url;
    _data['parent_code'] = parentCode;
    return _data;
  }

  static List<AdsModel> getDemoSliders() {
    return [
      AdsModel(title: 'Much more than the white coats', des: 'A Good and healthy body is the reason behind a healthy mind.', image: "assets/demo_sliders/african-americ.webp", page: "doctors", url: 'https://app.sebayet.in/', parentCode: ''),
      AdsModel(title: 'Your blood can give a life to someone.', des: 'Find blood banks near you', image: "assets/demo_sliders/bloodbank1.webp", page: 'blood_bank', url: 'https://app.sebayet.in/', parentCode: ''),
      AdsModel(title: 'Every life matters.', des: 'Every pet deserves a healthy, pain free mouth.', image: "assets/images/vat.jpg", page: 'pet', url: 'https://app.sebayet.in/', parentCode: ''),
      AdsModel(title: 'Goodbye Pain, Hello Freedom.', des: 'Treating The Cause of Pain, Not Just The Symptoms.', image: "assets/demo_sliders/physiotherapis.webp", page: 'physiotherapy', url: 'https://app.sebayet.in/', parentCode: ''),
    ];
  }
  static Future<List<AdsModel>?> getSliders() async {
    try {
      final sliders = await FirebaseDatabase.instance.ref().child(
          'btoc_app_sliders').get();
      final _sliders = sliders.value as Map;
      return _sliders.values.map((e) => AdsModel.fromJson(e)).toList();
    }catch(e){
      return null;
    }
  }
}
