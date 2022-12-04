// ignore_for_file: argument_type_not_assignable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sebayet_package/geo/utilities/location.dart';


class LocationAPI {
  LocationAPI();
  static const String url = 'https://geolocation-db.com/json/';
  static Future<WebLocationModel?> fetchData() async {
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final data = WebLocationModel.fromJson(json.decode(resp.body));
      return data;
    }
    return null;
  }
}
