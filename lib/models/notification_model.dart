import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.body,
    required this.image,
    required this.sendBy,
    required this.time,
    required this.id,
  });
  late final String title;
  late final String body;
  late final String? image;
  late final String? sendBy;
  late final String? time;
  late final String? id;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    image = json['image'];
    sendBy = json['send_by'];
    time = json['time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['body'] = body;
    _data['image'] = image;
    _data['send_by'] = sendBy;
    _data['time'] = time;
    _data['id'] = id;
    return _data;
  }

  static Future sendNotification(
      String uid, title, body, String senderUid) async {
    final dio = Dio();
    final notification = NotificationModel(
      title: title,
      body: body,
      time: DateTime.now().toString(),
      sendBy: senderUid,
      id: "",
      image: "",
    );
    FirebaseFirestore.instance.collection('tokens').doc(uid).get().then(
          (value) async => await dio.get(
            "https://providers.sebayet.in/api/sendNotification?apikey=AIzaSyC8-Qp4SHKetCOHJQmk3R02UjFNkr8QDdg&title=${notification.title}&body=${notification.body}&token=${value.data()!['token']}",
          ),
        );
    FirebaseDatabase.instance
        .ref()
        .child('notifications')
        .child(uid)
        .child(Timestamp.now().microsecondsSinceEpoch.toString())
        .set(notification.toJson());
  }
}
