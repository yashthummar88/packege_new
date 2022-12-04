import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sebayet_package/enums/enums.dart';
import 'package:sebayet_package/geo/src/geoflutterfire.dart';
import 'package:sebayet_package/geo/src/point.dart';
import 'package:sebayet_package/models/services_fees_map.dart';
import 'package:sebayet_package/models/user_model.dart';
import 'package:sebayet_package/sebayet_package.dart';

/// Search Index
/// Education Model
/// Multi Location
/// Achivements
extension toJSD on dynamic {
  Map<String, dynamic> toJson() {
    return this as Map<String, dynamic>;
  }
}

class DoctorModel {
  ///Basic Details
  late String email;
  late String gender;
  late String image;
  late String name;
  late String uid;
  late String about;
  late bool active;
  late Address address;
  late double lat;
  late double lng;
  late String category;
  late bool completeRegistration;
  late String phone;
  late String pincode;
  late String city;
  late String type;
  late List<String> languages;

  ///KYC Details
  late String idProof;
  late String medRegCoun;
  late String medRegNo;
  late String medRegYear;
  late String medicalProof;
  late String experience;
  late String fullAddress;
  late String degree;
  late String collage;
  late String medProfession;
  late String spec;
  late String specDegree;
  late String passOutYear;

  ///Search Indexed

  ///Clinic Details
  late String? clinicUid;
  late String? clinicName;
  late String? clinicPhone;
  late String? clinicAddress;
  late String? clinicCity;
  late String? clinicPinCode;
  late String? clinicPic;

  ///Pathology Details
  late String? pathologyRegNo;
  late String? pathologyRegPic;
  late List<String>? servicesList;
  late List<ServicesFeesMap>? servicesFees;

  DoctorModel({
    required this.about,
    required this.active,
    required this.address,
    required this.lat,
    required this.lng,
    required this.category,
    required this.city,
    required this.collage,
    required this.completeRegistration,
    required this.degree,
    required this.email,
    required this.experience,
    required this.fullAddress,
    required this.gender,
    required this.idProof,
    required this.image,
    required this.medRegCoun,
    required this.medRegNo,
    required this.medRegYear,
    required this.medicalProof,
    required this.name,
    required this.passOutYear,
    required this.phone,
    required this.pincode,
    required this.spec,
    required this.specDegree,
    required this.type,
    required this.medProfession,
    required this.clinicUid,
    required this.clinicName,
    required this.clinicPhone,
    required this.clinicAddress,
    required this.clinicCity,
    required this.clinicPinCode,
    required this.clinicPic,
    required this.pathologyRegNo,
    required this.pathologyRegPic,
    required this.uid,
    required this.languages,
    required this.servicesFees,
    required this.servicesList,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;

  DoctorModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    active = json['active'] ?? true;
    address = Address.fromJson(json['address']);
    lat = json['lat'] ?? 1.222;
    lng = json['lng'] ?? 1.222;
    category = json['category'];
    city = json['city'];
    collage = json['collage'];
    completeRegistration = json['completeRegistration'];
    degree = json['degree'];
    email = json['email'];
    experience = json['experience'];
    fullAddress = json['full_address'];
    gender = json['gender'];
    idProof = json['idProof'];
    image = json['image'];
    medRegCoun = json['medRegCoun'];
    medRegNo = json['medRegNo'];
    medRegYear = json['medRegYear'];
    medicalProof = json['medicalProof'];
    name = json['name'];
    passOutYear = json['passOutYear'];
    phone = json['phone'];
    pincode = json['pincode'];
    spec = json['spec'];
    specDegree = json['spec_degree'];
    type = json['type'];
    medProfession = json['medProfession'] ?? "";
    uid = json['uid'];
    clinicUid = json['clinic_uid'];
    clinicName = json['clinic_name'];
    clinicPhone = json['clinic_phone'];
    clinicAddress = json['clinic_address'];
    clinicCity = json['clinic_city'];
    clinicPinCode = json['clinic_pin_code'];
    clinicPic = json['clinic_pic'];
    pathologyRegNo = json['pathology_reg_no'];
    pathologyRegPic = json['pathology_reg_pic'];
    languages = ((json['languages'] as List?) ?? []).map((e) => e.toString()).toList();
    servicesFees = ((json['services_fees'] as List?) ?? []).map((e) => ServicesFeesMap.fromJson(e)).toList();
    servicesList = ((json['services'] as List?) ?? []).map((e) => e.toString()).toList();
  }
  DoctorModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> json) {
    var docJsonData = json.data()!;
    about = docJsonData['about'];
    active = docJsonData['active'];
    address = Address.fromJson(json.get('address'));
    lat = docJsonData['lat'] ?? 0.2222;
    lng = docJsonData['lng'] ?? 0.1112;
    category = docJsonData['category'];
    city = docJsonData['city'];
    collage = docJsonData['collage'];
    completeRegistration = docJsonData['completeRegistration'];
    degree = docJsonData['degree'];
    email = docJsonData['email'];
    experience = docJsonData['experience'];
    fullAddress = docJsonData['full_address'];
    gender = docJsonData['gender'];
    idProof = docJsonData['idProof'];
    image = docJsonData['image'];
    medRegCoun = docJsonData['medRegCoun'];
    medRegNo = docJsonData['medRegNo'];
    medRegYear = docJsonData['medRegYear'];
    medicalProof = docJsonData['medicalProof'];
    name = docJsonData['name'];
    passOutYear = docJsonData['passOutYear'];
    phone = docJsonData['phone'];
    pincode = docJsonData['pincode'];
    spec = docJsonData['spec'];
    specDegree = docJsonData['spec_degree'];
    type = docJsonData['type'].toString();
    medProfession = docJsonData['medProfession'] ?? "";
    uid = docJsonData['uid'];
    clinicUid = docJsonData['clinic_uid'];
    clinicName = docJsonData['clinic_name'];
    clinicPhone = docJsonData['clinic_phone'];
    clinicAddress = docJsonData['clinic_address'];
    clinicCity = docJsonData['clinic_city'];
    clinicPinCode = docJsonData['clinic_pin_code'];
    clinicPic = docJsonData['clinic_pic'];
    pathologyRegNo = docJsonData['pathology_reg_no'];
    pathologyRegPic = docJsonData['pathology_reg_pic'];
    languages = ((docJsonData['languages'] as List?) ?? [])
        .map((e) => e.toString())
        .toList();
    servicesList = ((docJsonData['services'] as List?) ?? [])
        .map((e) => e.toString())
        .toList();
    servicesFees = ((docJsonData['services_fees'] as List?) ?? [])
        .map((e) => ServicesFeesMap.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson({bool fromFb = false}) {
    Map<String, dynamic> data = {};
    data['about'] = about;
    data['active'] = active;
    data['address'] = fromFb?address.toFb():address.toJson();
    data['lat'] = lat;
    data['lng'] = lng;
    data['category'] = category;
    data['city'] = city;
    data['collage'] = collage;
    data['completeRegistration'] = completeRegistration;
    data['degree'] = degree;
    data['email'] = email;
    data['experience'] = experience;
    data['full_address'] = fullAddress;
    data['gender'] = gender;
    data['idProof'] = idProof;
    data['image'] = image;
    data['medRegCoun'] = medRegCoun;
    data['medRegNo'] = medRegNo;
    data['medRegYear'] = medRegYear;
    data['medicalProof'] = medicalProof;
    data['name'] = name;
    data['passOutYear'] = passOutYear;
    data['phone'] = phone;
    data['pincode'] = pincode;
    data['spec'] = spec;
    data['spec_degree'] = specDegree;
    data['type'] = type;
    data['medProfession'] = medProfession;
    data['uid'] = uid;
    data['clinic_uid'] = clinicUid;
    data['clinic_name'] = clinicName;
    data['clinic_phone'] = clinicPhone;
    data['clinic_address'] = clinicAddress;
    data['clinic_city'] = clinicCity;
    data['clinic_pin_code'] = clinicPinCode;
    data['clinic_pic'] = clinicPic;
    data['pathology_reg_no'] = pathologyRegNo;
    data['pathology_reg_pic'] = pathologyRegPic;
    data['languages'] = languages;
    data['services_fees'] = servicesFees!=null?(servicesFees!.map((e) => e.toJson()).toList()):[];
    data['services'] = servicesList??[];
    return data;
  }

  static DoctorModel? currentDoctor() {
    final userDate = SebayetPackage.preferences.getString('doctor_data');
    if (userDate != null) {
      return DoctorModel.fromJson(jsonDecode(userDate.toString()));
    } else {
      return null;
    }
  }

  static Future<DoctorModel> getDoctor(docId) async {
    var doc =
        await FirebaseFirestore.instance.collection('doctors').doc(docId).get();
    return DoctorModel.fromDocument(doc);
  }
  static Future<void> setUser(DoctorModel user) async {
    final decoded = jsonEncode(user.toJson());
    await SebayetPackage.preferences.setString('doctor_data',decoded);
  }

  static Future<DoctorModel?> checkUser(String uid) async{
    final user = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid).get();
    return user.exists?DoctorModel.fromDocument(user):null;
  }
  static Future<bool> registerUser(String uid,DoctorModel doctor,UserModel user)async{
    await FirebaseFirestore.instance.collection('doctors').doc(uid).set(doctor.toJson());
    await FirebaseFirestore.instance.collection('user').doc(uid).set(user.toJson());
    await UserModel.setUser(user);
    await DoctorModel.setUser(doctor);
    return false;
  }
  static Future<DoctorModel> getClinic(docId) async {
    var doc =
        await FirebaseFirestore.instance.collection('doctors').doc(docId).get();
    return DoctorModel.fromDocument(doc);
  }

  static Future<List<DoctorModel>> getDoctors({int limit = 3,UserType? type,required GeoPoint point}) async {
    var query = FirebaseFirestore.instance.collection("doctors").where(
      'active',
      isEqualTo: true,
    );
    if (type != null) {
      query = query.where('type', isEqualTo: type.toString());
    }
    query = query.limit(limit);
    final geo = Geoflutterfire();
    var radius = BehaviorSubject<double>.seeded(200.0);
    GeoFirePoint center = geo.point(
      latitude: point.latitude,
      longitude: point.longitude,
    );
    final stream = await radius.switchMap(
          (rad) => geo
          .collection(
        collectionRef: query,
      )
          .within(
        center: center,
        radius: rad,
        field: 'address',
        strictMode: true,
      ),
    ).first;
    final list = stream.map((e) => DoctorModel.fromDocument(e)).toList();
    return list;
  }

  static Stream<List<DocumentSnapshot<Map<String, dynamic>>>> get({
    required GeoPoint? point,
    UserType? type,
    String? category,
    String? city,
    List<String>? services,
    int limit = 10,
    DocumentSnapshot<Map<String, dynamic>>? lastDoc,
    bool isActives = true,
  }) {
    var query = FirebaseFirestore.instance.collection("doctors").where(
          'active',
          isEqualTo: isActives,
        );
    if (type != null) {
      query = query.where('type', isEqualTo: type.toString());
    }
    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (city != null) {
      query = query.where('city', isEqualTo: city);
    }
    if (services != null) {
      query = query.where('services', arrayContainsAny: services);
    }
    if (lastDoc != null) {
      query = query.startAfter([lastDoc]);
    }
    query = query.limit(limit);
    if(point!=null) {
      final geo = Geoflutterfire();
      var radius = BehaviorSubject<double>.seeded(200.0);
      GeoFirePoint center = geo.point(
        latitude: point.latitude,
        longitude: point.longitude,
      );
      final stream = radius.switchMap(
            (rad) =>
            geo
                .collection(
              collectionRef: query,
            )
                .within(
              center: center,
              radius: rad,
              field: 'address',
              strictMode: true,
            ),
      );
      final list = stream.map((event) => event);
      return list;
    }else{
      final list = query.snapshots().map((event) => event.docs);
      return list;
    }
  }

  static Future<List<DoctorModel>> getClinicDoctors(String clinicUid) async {
    final query = FirebaseFirestore.instance
        .collection("doctors")
        .where('clinic_uid', isEqualTo: clinicUid);
    final q = await query.get();
    return q.docs.map((e) => DoctorModel.fromDocument(e)).toList();
  }

  static Future<List<String>> getMyDoctors(uid) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection("my_doctor")
        .get();
    return query.docs.map((e) => e.id).toList();
  }
}

class Address {
  late String geohash;
  late GeoPoint geopoint;
  Address({required this.geohash, required this.geopoint});

  Address.fromFb(Map<String, dynamic> json) {
    geohash = json['geohash'];
    geopoint = json['geopoint'] as GeoPoint;
  }

  Address.fromJson(Map<String, dynamic> json) {
    geohash = json['geohash'];
    geopoint = GeoPoint(json['geopoint']['longitude'],json['geopoint']['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['geohash'] = geohash;
    final geopoi = {
      "longitude":geopoint.longitude,
      "latitude": geopoint.latitude,
    };
    data['geopoint'] = geopoi;
    return data;
  }

  Map<String, dynamic> toFb() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['geohash'] = geohash;
    data['geopoint'] = geopoint;
    return data;
  }

  Address copyWith({
    String? geohash,
    GeoPoint? geopoint,
  }) {
    return Address(
      geohash: geohash ?? this.geohash,
      geopoint: geopoint ?? this.geopoint,
    );
  }
}
