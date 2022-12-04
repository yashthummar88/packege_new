import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class BloodBank {
  static Future<List<List<String>>> getList({
    required String stateCode,
    required String distCode,
    required String bloodGroup,
    required String bloodComponent,
  }) async {
    final dio = Dio();
    final resp = await dio.get("https://www.eraktkosh.in/BLDAHIMS/bloodbank/nearbyBB.cnt?hmode=GETNEARBYSTOCKDETAILS&stateCode=$stateCode&districtCode=$distCode&bloodGroup=$bloodGroup&bloodComponent=$bloodComponent&lang=0&_=1662826088825");
    print(resp.data.toString());
    final list = jsonDecode(resp.data)['data'] as List;
    return list.map((e) => (e as List).map((e) => e.toString()).toList()).toList();
  }
}
