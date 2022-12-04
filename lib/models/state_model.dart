import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class StateModel {
  StateModel({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['value'];
    name = json['label'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = id;
    _data['label'] = name;
    return _data;
  }
}

class DistModel {
  DistModel({
    required this.id,
    required this.value,
  });
  late final String id;
  late final String value;

  DistModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['value'] = value;
    return _data;
  }
}

mixin StateDistData {
  static String value = "value";
  static String label = "label";
  static Future<List<DistModel>> getDistList(String stateCode) async {
    final dio = Dio();
    final resp = await dio.get("https://www.eraktkosh.in//BLDAHIMS/bloodbank/nearbyBB.cnt?hmode=GETDISTRICTLIST&selectedStateCode=$stateCode");
    final distList = jsonDecode(resp.data.toString())['records'] as List;
    final list = distList.map((e) => DistModel.fromJson(e)).toList();
    return list;
  }
  static List<StateModel> stateList = {
    0: {value: '28', label: 'Andhra Pradesh'},
    1: {value: '12', label: 'Arunachal Pradesh'},
    2: {value: '18', label: 'Assam'},
    3: {value: '10', label: 'Bihar'},
    4: {value: '94', label: 'Chandigarh'},
    5: {value: '22', label: 'Chhattisgarh'},
    6: {value: '26', label: 'Dadra & Nagar Haveli'},
    7: {value: '25', label: 'Daman & Diu'},
    8: {value: '97', label: 'Delhi'},
    9: {value: '30', label: 'Goa'},
    10: {value: '24', label: 'Gujarat'},
    11: {value: '96', label: 'Haryana'},
    12: {value: '92', label: 'Himachal Pradesh'},
    13: {value: '91', label: 'Jammu and Kashmir'},
    14: {value: '20', label: 'Jharkhand'},
    15: {value: '29', label: 'Karnataka'},
    16: {value: '32', label: 'Kerala'},
    17: {value: '37', label: 'Ladakh'},
    18: {value: '31', label: 'Lakshadweep'},
    19: {value: '23', label: 'Madhya Pradesh'},
    20: {value: '27', label: 'Maharashtra'},
    21: {value: '14', label: 'Manipur'},
    22: {value: '17', label: 'Meghalaya'},
    23: {value: '15', label: 'Mizoram'},
    24: {value: '13', label: 'Nagaland'},
    25: {value: '21', label: 'Odisha'},
    26: {value: '34', label: 'Puducherry'},
    27: {value: '93', label: 'Punjab'},
    28: {value: '98', label: 'Rajasthan'},
    29: {value: '11', label: 'Sikkim'},
    30: {value: '33', label: 'Tamil Nadu'},
    31: {value: '36', label: 'Telangana'},
    32: {value: '16', label: 'Tripura'},
    33: {value: '95', label: 'Uttarakhand'},
    34: {value: '99', label: 'Uttar Pradesh'},
    35: {value: '19', label: 'West Bengal'},
  }.values.map((e) => StateModel.fromJson(e)).toList();
}
