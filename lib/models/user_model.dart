import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sebayet_package/enums/enums.dart';
import 'package:sebayet_package/sebayet_package.dart';

class UserModel {
  bool? completeRegister;
  String? email;
  String? gender;
  String? name;
  String? phoneNo;
  String? profilePics;
  String? surname;
  String? uid;
  String? role;
  String? weight;
  List<UserModel>? myFamily;

  UserModel({
    this.completeRegister,
    this.email,
    this.gender,
    this.name,
    this.phoneNo,
    this.profilePics,
    this.surname,
    this.role,
    this.weight,
    this.uid,
    this.myFamily,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    myFamily =
        []; //json['my_family']!=null?(json['my_family'] as List<Map<String,dynamic>>).map((e) => UserModel.fromJson(e)).toList():[];
    completeRegister = json['CompleteRegister'];
    email = json['email'];
    gender = json['gender'];
    name = json['name'];
    weight = json['weight'] ?? "65 KG";
    phoneNo = json['phoneNo'];
    profilePics = json['profilePics'];
    surname = json['surname'];
    uid = json['uid'];
    role = json['role'] ?? UserType.user.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['my_family'] = this.myFamily == null
        ? []
        : this.myFamily!.map((e) => e.toJson()).toList();
    data['CompleteRegister'] = this.completeRegister;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['profilePics'] = this.profilePics;
    data['surname'] = this.surname;
    data['uid'] = this.uid;
    data['role'] = this.role;
    return data;
  }

  Map<String, dynamic> decode() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompleteRegister'] = this.completeRegister;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['profilePics'] = this.profilePics;
    data['surname'] = this.surname;
    data['uid'] = this.uid;
    data['role'] = this.role;
    return data;
  }

  static UserModel getUser() {
    final userDate = SebayetPackage.preferences.getString('user_data');
    if (userDate != null) {
      return UserModel.fromJson(jsonDecode(userDate.toString()));
    } else {
      return UserModel();
    }
  }

  static Future<void> setUser(UserModel user) async {
    final decoded = jsonEncode(user.toJson());
    await SebayetPackage.preferences.setString('user_data', decoded);
  }

  static Future<UserModel?> checkUser(String uid) async {
    final user =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    return user.exists ? UserModel.fromJson(user.data()!) : null;
  }

  static Future<UserModel> register(User firebaseUser,UserModel userData) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(firebaseUser.uid)
        .set(userData.toJson());
    var user = UserModel.fromJson(userData.toJson());
    SebayetPackage.preferences
        .setString('user_data', jsonEncode(user.decode()));
    return user;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> addMember(
      {required String email,
      required String name,
      required String gender,
      required String phoneNo,
      required String profilePic,
      required String surname,
      required String weight,
      required String uid}) async {
    final userData = UserModel(
      completeRegister: true,
      email: email,
      gender: gender,
      name: name,
      phoneNo: phoneNo,
      profilePics: profilePic,
      surname: surname,
      weight: weight,
      uid: uid,
    );
    final dat = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('family_members')
        .add(userData.toJson());
    return dat.get();
  }

  static Future<String?> genToken({
    required String channel,
    required String uid,
  }) async {
    final dio = Dio();
    final resp = await dio.get("https://providers.sebayet.in/api/generate_token?channelName=$channel&uid=$uid&role=publisher&expireTime=3600");
    final respData = jsonDecode(jsonEncode(resp.data));
    log("agora_token : $respData");
    try {
      if (respData['token'] != null) {
        return respData['token'];
      } else {
        return null;
      }
    } catch (e) {
      log("agora_token_error : $e");
      return null;
    }
  }
}
