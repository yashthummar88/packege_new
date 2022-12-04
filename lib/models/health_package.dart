import 'package:cloud_firestore/cloud_firestore.dart';

class HealthPackageModel {
  HealthPackageModel({
    required this.id,
    required this.url,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.preparation,
    required this.price,
    required this.rating,
    required this.testIds,
    required this.clinicUid,
    required this.gender,
    required this.samplesRequired,
    required this.isRadiology,
    required this.fees,
    required this.subServices,
    required this.isActive,
    required this.isApproved,
  });
  late final String id;
  late final String url;
  late final String title;
  late final String subtitle;
  late final String description;
  late final String preparation;
  late final String price;
  late final String rating;
  late final String? clinicUid;
  late final List<String> testIds;
  late final List<String> subServices;
  late final List<String> samplesRequired;
  late final String gender;
  late final bool? isRadiology;
  late final String? fees;
  late final bool isApproved;
  late final bool isActive;

  HealthPackageModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    url = json['url'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    preparation = json['preparation']??"";
    price = json['price'];
    rating = json['rating'];
    clinicUid = json['clinic_uid'];
    isActive = json['is_active']??false;
    isApproved = json['is_approved']??false;
    isRadiology = json['isRadiology'] ?? false;
    subServices = json['sub_services'] != null
        ? (json['sub_services'] as List).map((e) => e.toString()).toList()
        : <String>[];
    samplesRequired = json['samplesRequired'] != null
        ? (json['samplesRequired'] as List).map((e) => e.toString()).toList()
        : <String>[];
    gender = json['gender'] ?? "Both";
    fees = json['fees']??"";
    testIds = (json['test_ids'] as List).toList().map((e)=>e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['url'] = url;
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['description'] = description;
    _data['preparation'] = preparation;
    _data['price'] = price;
    _data['rating'] = rating;
    _data['test_ids'] = testIds;
    _data['clinic_uid'] = clinicUid;
    _data['sub_services'] = subServices;
    _data['isRadiology'] = isRadiology;
    _data['samplesRequired'] = samplesRequired;
    _data['gender'] = gender;
    _data['fees'] = fees;
    _data['is_active'] = isActive;
    _data['is_approved'] = isApproved;
    return _data;
  }
  static Future<List<HealthPackageModel>> getHealthPackages(
      {int? limit}) async {
    if (limit != null) {
      final query = FirebaseFirestore.instance.collection("health_package").where('price',isNotEqualTo: "").limit(limit);
      final q = await query.get();
      return q.docs.map((e) => HealthPackageModel.fromJson(e.data())).toList();
    } else {
      final query = FirebaseFirestore.instance.collection("health_package").where('price',isNotEqualTo: "");
      final q = await query.get();
      return q.docs.map((e) => HealthPackageModel.fromJson(e.data())).toList();
    }
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthPackageModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  HealthPackageModel copyWith({
    String? id,
    String? url,
    String? title,
    String? subtitle,
    String? description,
    String? preparation,
    String? price,
    String? rating,
    String? clinicUid,
    List<String>? testIds,
    List<String>? subServices,
    List<String>? samplesRequired,
    String? gender,
    bool? isRadiology,
    String? fees,
    bool? isActive,
    bool? isApproved,
  }) {
    return HealthPackageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      preparation: preparation ?? this.preparation,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      clinicUid: clinicUid ?? this.clinicUid,
      testIds: testIds ?? this.testIds,
      subServices: subServices ?? this.subServices,
      samplesRequired: samplesRequired ?? this.samplesRequired,
      gender: gender ?? this.gender,
      isRadiology: isRadiology ?? this.isRadiology,
      fees: fees ?? this.fees,
      isActive: isActive ?? this.isActive,
      isApproved: isApproved ?? this.isApproved,
    );
  }

}