import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  LocationModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.address,
    required this.lat,
    required this.lang,
    required this.gurl,
    required this.name,
  });
  late final String id;
  late final String doctorId;
  late final String doctorName;
  late final String address;
  late final String lat;
  late final String lang;
  late final String gurl;
  late final String name;

  LocationModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    gurl = json['gurl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['doctor_id'] = doctorId;
    _data['doctor_name'] = doctorName;
    _data['address'] = address;
    _data['lat'] = lat;
    _data['lang'] = lang;
    _data['gurl'] = gurl;
    _data['name'] = name;
    return _data;
  }

  static Future<List<LocationModel>> getDoctorLocations(uid)async{
    final result = await FirebaseFirestore.instance.collection('locations').where('doctor_id',isEqualTo: uid).get();
    return result.docs.map((e) => LocationModel.fromJson(e.data())).toList();
  }
  static Future<LocationModel> saveLocation(LocationModel location)async{
    await FirebaseFirestore.instance.collection('locations').doc(location.id).set(location.toJson());
    return location;
  }
  static Future<void> deleteLocation(LocationModel location)async{
    await FirebaseFirestore.instance.collection('locations').doc(location.id).delete();
  }
}