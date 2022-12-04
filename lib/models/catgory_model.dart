import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? color;
  String? color2;
  String? description;
  String? image;
  String? title;

  CategoryModel(
      {this.color, this.color2, this.description, this.image, this.title});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    color2 = json['color_2'];
    description = json['description'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['color_2'] = color2;
    data['description'] = description;
    data['image'] = image;
    data['title'] = title;
    return data;
  }
  static Future<List<CategoryModel>> getCategory({int? limit}) async {
    if(limit!=null){
      final data = await FirebaseFirestore.instance.collection("category").limit(limit).get();
      return data.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
    }
    final data = await FirebaseFirestore.instance.collection("category").get();
    return data.docs
        .map((e) => CategoryModel.fromJson(e.data()))
        .toList();
  }
}