import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sebayet_package/models/services_fees_map.dart';

class ServicesModel {
  late String id;
  late Color color;
  late String description;
  late String image;
  late String title;
  late String details;
  late String preparation;
  late List<String> subServices;
  late List<String> samplesRequired;
  late String gender;
  late bool? isRadiology;
  late String? fees;
  ServicesModel({
    required this.id,
    required this.color,
    required this.description,
    required this.image,
    required this.title,
    required this.subServices,
    required this.details,
    required this.preparation,
    required this.gender,
    required this.samplesRequired,
    required this.isRadiology,
    required this.fees,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isRadiology == other.isRadiology;

  @override
  int get hashCode => id.hashCode ^ isRadiology.hashCode;

  ServicesModel.fromJson(Map<String, dynamic> json, String uid) {
    id = uid;
    color = Color(int.parse("0x${json['color']}"));
    description = json['description'];
    image = json['image'];
    title = json['title'];
    details = json['details'] ?? "";
    preparation = json['preparation'] ?? "";
    isRadiology = json['isRadiology'] ?? false;
    subServices = json['sub_services'] != null
        ? (json['sub_services'] as List).map((e) => e.toString()).toList()
        : <String>[];
    samplesRequired = json['samplesRequired'] != null
        ? (json['samplesRequired'] as List).map((e) => e.toString()).toList()
        : <String>[];
    gender = json['gender'] ?? "Both";
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['color'] = color.value.toRadixString(16);
    data['description'] = description;
    data['image'] = image;
    data['title'] = title;
    data['details'] = details;
    data['sub_services'] = subServices;
    data['preparation'] = preparation;
    data['isRadiology'] = isRadiology;
    data['samplesRequired'] = samplesRequired;
    data['gender'] = gender;
    data['fees'] = fees;
    return data;
  }

  static late List<ServicesModel> services;
  static Future<List<ServicesModel>> getServices({int? limit}) async {
    if(limit!=null){
      final sliders =
      await FirebaseFirestore.instance.collection('services').limit(limit).get();
      return sliders.docs
          .map((e) => ServicesModel.fromJson(e.data(), e.id))
          .toList();
    }
    final sliders =
        await FirebaseFirestore.instance.collection('services').get();
    return sliders.docs
        .map((e) => ServicesModel.fromJson(e.data(), e.id))
        .toList();
  }

  static ServicesModel getService(String title) {
    final service = services.where((element) => element.title == title).first;
    return service;
  }

  static Future updateLabServices(
      List<ServicesModel> services, List<ServicesFeesMap> servicesFees, String uid) async {
    final services_fees = servicesFees.map((e) => e.toJson()).toList();
    final Map<String,dynamic> data = {};
    data.addAll({
      'services': services.map((e) => e.title).toList(),
    });
    if(services_fees.isNotEmpty) {
      data.addAll({
        "services_fees": services_fees,
      });
    }
    FirebaseFirestore.instance.collection('doctors').doc(uid).update(
      data,
    );
  }

  static Stream<List<ServicesModel>> getLabServices(String uid) {
    final serv =
        FirebaseFirestore.instance.collection('doctors').doc(uid).snapshots();
    final list = serv.map((event) =>
        ((event.data()!['services'] as List?) ?? [])
            .map((e) => getService(e.toString()))
            .toList());
    return list;
  }

  static Stream<List<ServicesFeesMap>> getLabServicesFees(String uid) {
    final serv =
        FirebaseFirestore.instance.collection('doctors').doc(uid).snapshots();
    final list = serv.map((event) =>
        ((event.data()!['services_fees'] as List?) ?? [])
            .map((e) => ServicesFeesMap.fromJson(e))
            .toList());
    return list;
  }

  ServicesModel copyWith({
    String? id,
    Color? color,
    String? description,
    String? image,
    String? title,
    String? details,
    String? preparation,
    List<String>? subServices,
    List<String>? samplesRequired,
    String? gender,
    bool? isRadiology,
    String? fees,
  }) {
    return ServicesModel(
      id: id ?? this.id,
      color: color ?? this.color,
      description: description ?? this.description,
      image: image ?? this.image,
      title: title ?? this.title,
      details: details ?? this.details,
      preparation: preparation ?? this.preparation,
      subServices: subServices ?? this.subServices,
      samplesRequired: samplesRequired ?? this.samplesRequired,
      gender: gender ?? this.gender,
      isRadiology: isRadiology ?? this.isRadiology,
      fees: fees ?? this.fees,
    );
  }
}
