// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sebayet_package/models/doctor_model.dart';
import 'package:sebayet_package/models/graph_data_model.dart';
import 'package:sebayet_package/models/location_model.dart';
import 'package:sebayet_package/models/slot_model.dart';
import '../enums/enums.dart';

class AppointmentModel {
  String? id;
  String? uid;
  Timestamp? date;
  List<Slot> slots = [];
  List<Slot> bookedSlots = [];
  String? doctorId;
  String? doctorName;
  String? doctorAddress;
  double? doctorLat;
  double? doctorLng;
  BookingType? type;
  String? statusCode;
  String? status;
  String? fees;
  Timestamp? createdOn;
  LocationModel? location;
  String? clinicUid;
  late String timeLimit;

  AppointmentModel({
    required this.id,
    required this.uid,
    required this.date,
    required this.slots,
    required this.bookedSlots,
    required this.doctorId,
    required this.doctorName,
    required this.doctorAddress,
    required this.doctorLat,
    required this.doctorLng,
    required this.createdOn,
    required this.statusCode,
    required this.status,
    required this.fees,
    required this.type,
    required this.location,
    required this.clinicUid,
    required this.timeLimit,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json, String docId) {
    try {
      id = docId;
      uid = json['uid'];
      clinicUid = json['clinic_uid'];
      slots = (json['slots'] as List).map((e) => Slot.fromJson(e)).toList();
      bookedSlots =
          (json['booked_slots'] as List).map((e) => Slot.fromJson(e)).toList();
      doctorId = json['doctor_id'];
      doctorName = json['doctor_name'];
      doctorAddress = json['doctor_address'];
      doctorLat = json['doctor_lat'];
      doctorLng = json['doctor_lng'];
      type = json['type'] == BookingType.videoCall.toString()
          ? BookingType.videoCall
          : BookingType.clinicVisit;
      createdOn = json['created_on'];
      statusCode = json['status_code'];
      status = json['status'];
      fees = json['fees'];
      date = json['date'];
      timeLimit = json['time_limit'];
      location = json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['clinic_uid'] = clinicUid;
    data['id'] = id;
    data['slots'] = slots.map((e) => e.toJson()).toList();
    data['booked_slots'] = bookedSlots.map((e) => e.toJson()).toList();
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['doctor_address'] = doctorAddress;
    data['doctor_lat'] = doctorLat;
    data['doctor_lng'] = doctorLng;
    data['type'] = type.toString();
    data['created_on'] = createdOn;
    data['status_code'] = statusCode;
    data['status'] = status;
    data['fees'] = fees;
    data['time_limit'] = timeLimit;
    data['date'] = date;
    data['location'] = location != null ? location!.toJson() : null;
    return data;
  }

  static Future<void> addAppointment({
    required List<DateTime> selectedDays,
    required List<TimeOfDay> selectedSlots,
    required DoctorModel doctor,
    required BookingType bookingType,
    required String fees,
    required LocationModel location,
    required String timeLimit,
  }) async {
    selectedDays.forEach((date) async {
      final aid =
          "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
      final auid = "${Timestamp.now().millisecondsSinceEpoch}#${doctor.uid}";
      final app = AppointmentModel(
        id: aid,
        uid: auid,
        timeLimit: timeLimit,
        clinicUid: doctor.clinicUid,
        bookedSlots: [],
        date: Timestamp.fromDate(date),
        slots: selectedSlots
            .map(
              (e) => Slot(
                  id: "${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}",
                  fees: fees,
              ),
            )
            .toList(),
        doctorLng: doctor.lng,
        doctorId: doctor.uid,
        type: doctor.type == UserType.pathology.toString()
            ? BookingType.pathology
            : doctor.type == UserType.physiotherapy.toString()
                ? BookingType.physiotherapy
                : bookingType,
        doctorLat: doctor.lat,
        status: 'Created',
        doctorAddress: doctor.fullAddress,
        statusCode: StatusCode.booked.toString(),
        createdOn: Timestamp.now(),
        doctorName: doctor.type == UserType.pathology.toString()
            ? doctor.clinicName
            : doctor.name,
        fees: fees,
        location: location,
      );
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(app.uid)
          .set(app.toJson());
      await GraphDataModel.addAppointmentLog(app.doctorId!, app.uid!, app.date!.toDate(), app.slots.length);
    });
    await Future.delayed(const Duration(seconds: 30));
  }

  static Stream<List<AppointmentModel>> getDoctorAppointments(
      String uid, DateTime startDate, DateTime endDate) {
    final q = FirebaseFirestore.instance
        .collection('appointments')
        .where('doctor_id', isEqualTo: uid)
        .where('date', isLessThan: Timestamp.fromDate(endDate))
        .where('date', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('date')
        .snapshots();
    return q.map((event) => event.docs
        .map((e) => AppointmentModel.fromJson(e.data(), e.id))
        .toList());
  }

  static Stream<List<AppointmentModel>> getClinicAppointments(
      String uid, DateTime startDate, DateTime endDate) {
    final q = FirebaseFirestore.instance
        .collection('appointments')
        .where('clinic_uid', isEqualTo: uid)
        .where('date', isLessThan: Timestamp.fromDate(endDate))
        .where('date', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('date')
        .snapshots();
    return q.map((event) => event.docs
        .map((e) => AppointmentModel.fromJson(e.data(), e.id))
        .toList());
  }

  static Stream<AppointmentModel> getAppointment(String uid) {
    final q = FirebaseFirestore.instance
        .collection('appointments')
        .doc(uid)
        .snapshots();
    return q.map((e) => AppointmentModel.fromJson(e.data()!, e.id));
  }

  AppointmentModel copyWith({
    String? id,
    String? uid,
    Timestamp? date,
    List<Slot>? slots,
    List<Slot>? bookedSlots,
    String? doctorId,
    String? doctorName,
    String? doctorAddress,
    double? doctorLat,
    double? doctorLng,
    BookingType? type,
    String? statusCode,
    String? status,
    String? fees,
    Timestamp? createdOn,
    LocationModel? location,
    String? clinicUid,
    String? timeLimit,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      date: date ?? this.date,
      slots: slots ?? this.slots,
      bookedSlots: bookedSlots ?? this.bookedSlots,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorAddress: doctorAddress ?? this.doctorAddress,
      doctorLat: doctorLat ?? this.doctorLat,
      doctorLng: doctorLng ?? this.doctorLng,
      type: type ?? this.type,
      statusCode: statusCode ?? this.statusCode,
      status: status ?? this.status,
      fees: fees ?? this.fees,
      createdOn: createdOn ?? this.createdOn,
      location: location ?? this.location,
      clinicUid: clinicUid ?? this.clinicUid,
      timeLimit: timeLimit ?? this.timeLimit,
    );
  }
}
