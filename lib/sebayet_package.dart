library sebayet_package;

import 'package:shared_preferences/shared_preferences.dart';

class SebayetPackage {
  static late SharedPreferences preferences;
  static String upiID = "shantanupal850@okicici";
  static String appID = "807a3eb5d0834b78b3e749141790aada";
  static String appCert = "228ead97879343d2992e951111335330";
  static String payKey = "rzp_live_9n10cJbto8KOj8";
  static String mapKey = "AIzaSyBcdO2cJrisfiWkVY0uPbbhNfzhPpS6iPw";
  static String cloudApiKey = "AIzaSyC8-Qp4SHKetCOHJQmk3R02UjFNkr8QDdg";
  static String mapMyIndia = "dd6xygxe3e3kbyteu6zxb8ntpsd6hch7";
  static Map<String,String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Headers": "Origin,Content-Type",
    "Access-Control-Allow-Methods": "POST, GET",
    'Content-Type': 'application/json'
  };
}
