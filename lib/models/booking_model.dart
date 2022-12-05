// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sebayet_package/enums/enums.dart';
import 'package:sebayet_package/models/appointment_model.dart';
import 'package:sebayet_package/models/graph_data_model.dart';
import 'package:sebayet_package/models/health_package.dart';
import 'package:sebayet_package/models/location_model.dart';
import 'package:sebayet_package/models/payment_model.dart';
import 'package:sebayet_package/models/service_model.dart';
import 'package:sebayet_package/models/slot_model.dart';
import 'package:sebayet_package/models/success_faliure_model.dart';
import 'package:sebayet_package/models/user_model.dart';

class BookingModel {
  BookingModel({
    required this.uid,
    required this.appointmentId,
    required this.doctorId,
    required this.appointmentTime,
    required this.slotId,
    required this.bookingTime,
    required this.patientName,
    required this.patientDetails,
    required this.userId,
    required this.memberId,
    required this.appointmentType,
    required this.appointmentDetails,
    required this.verificationCode,
    required this.fees,
    required this.statusCode,
    required this.paymentID,
    required this.category,
    required this.doctorName,
    required this.medType,
    required this.rebookID,
    required this.prescriptionUrl,
    required this.location,
    required this.service,
    required this.clinicUid,
    required this.linkId,
    required this.appointmentLength,
    required this.healthPackage,
  });
  late final String uid;
  late final String appointmentId;
  late final String doctorId;
  late final Timestamp appointmentTime;
  late final String slotId;
  late final String bookingTime;
  late final String patientName;
  late final String patientDetails;
  late final String userId;
  late final String memberId;
  late final String appointmentType;
  late final String appointmentDetails;
  late final String verificationCode;
  late final String fees;
  late final String statusCode;

  late final String paymentID;
  late final String doctorName;
  late final String category;
  late final String medType;
  late final String rebookID;
  late final String prescriptionUrl;
  late final LocationModel? location;
  late final ServicesModel? service;
  late final String? clinicUid;
  late final String? linkId;
  late final String appointmentLength;
  late final HealthPackageModel? healthPackage;

  BookingModel.fromJson(Map<String, dynamic> json, String uuid) {
    uid = uuid;
    clinicUid = json['clinic_uid'];
    appointmentId = json['appointment_id'];
    doctorId = json['doctor_id'];
    appointmentTime = json['appointment_time'];
    slotId = json['slot_id'];
    bookingTime = json['booking_time'];
    patientName = json['patient_name'];
    patientDetails = json['patient_details'];
    userId = json['user_id'];
    memberId = json['member_id'];
    appointmentType = json['appointment_type'];
    appointmentDetails = json['appointment_details'];
    verificationCode = json['verification_code'];
    fees = json['fees'] ?? "";
    statusCode = json['status_code'];
    paymentID = json['payment_id'] ?? "";
    doctorName = json['doctor_name'] ?? "";
    category = json['category'] ?? "";
    medType = json['med_type'] ?? "";
    rebookID = json['rebook_id'] ?? "";
    linkId = json['link_id'];
    prescriptionUrl = json['prescription_url'] ?? "";
    appointmentLength = json['appointment_length'];
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    service = json['service'] != null
        ? ServicesModel.fromJson(json['service'], '')
        : null;
    healthPackage = json['health_package'] != null
        ? HealthPackageModel.fromJson(json['health_package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['clinic_uid'] = clinicUid;
    data['appointment_id'] = appointmentId;
    data['doctor_id'] = doctorId;
    data['appointment_time'] = appointmentTime;
    data['slot_id'] = slotId;
    data['booking_time'] = bookingTime;
    data['patient_name'] = patientName;
    data['patient_details'] = patientDetails;
    data['user_id'] = userId;
    data['member_id'] = memberId;
    data['appointment_type'] = appointmentType;
    data['appointment_details'] = appointmentDetails;
    data['verification_code'] = verificationCode;
    data['status_code'] = statusCode;
    data['payment_id'] = paymentID;
    data['doctor_name'] = doctorName;
    data['category'] = category;
    data['med_type'] = medType;
    data['rebook_id'] = rebookID;
    data['fees'] = fees;
    data['link_id'] = linkId;
    data['prescription_url'] = prescriptionUrl;
    data['appointment_length'] = appointmentLength;
    data['location'] = location != null ? location!.toJson() : null;
    data['service'] = service != null ? service!.toJson() : null;
    data['health_package'] =
        healthPackage != null ? healthPackage!.toJson() : null;
    return data;
  }

  bool isMissed() {
    final limit =
        DateTime.now().add(const Duration(minutes: 2)).millisecondsSinceEpoch;
    if (limit > appointmentTime.millisecondsSinceEpoch) {
      if (statusCode != "StatusCode.completed") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String timeRemaining() {
    if (appointmentTime.toDate().difference(DateTime.now()).inMinutes >= 0) {
      if (appointmentTime.toDate().difference(DateTime.now()).inMinutes < 60) {
        return "${appointmentTime.toDate().difference(DateTime.now()).inMinutes} Minutes";
      } else {
        return "${appointmentTime.toDate().difference(DateTime.now()).inHours} Hours";
      }
    } else {
      return "";
    }
  }

  static Future<List<BookingModel>> getMyBookings(uid) async {
    final q = await FirebaseFirestore.instance
        .collection('bookings')
        .where('user_id', isEqualTo: uid)
        .orderBy('appointment_time', descending: false)
        .get();
    return q.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList();
  }

  static Stream<List<BookingModel>> getCalenderBookings(
      DateTime date, String uid) {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = startDate.add(const Duration(days: 1));
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('doctor_id', isEqualTo: uid)
        .where('appointment_time', isLessThan: endDate)
        .where('appointment_time', isGreaterThan: startDate)
        .orderBy('appointment_time', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<BookingModel>> getMyCalenderBookings(
      DateTime startDate, DateTime endDate, String uid) {
    // final startDate = DateTime(date.year, date.month, date.day);
    // final endDate = startDate.add(const Duration(days: 1));
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('doctor_id', isEqualTo: uid)
        .where('appointment_time', isLessThan: endDate)
        .where('appointment_time', isGreaterThan: startDate)
        .orderBy('appointment_time', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<BookingModel>> getBookings(uid) {
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('appointment_id', isEqualTo: uid)
        .orderBy('appointment_time', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  }

  static Future<bool> verifyBooking(uid) async {
    return false;
  }

  static Future<void> addBooking(BookingModel bookingModel) async {}
  static Stream<List<BookingModel>> getBookingsMonth(
      DateTime startDate, DateTime endDate, String uid) {
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('doctor_id', isEqualTo: uid)
        .where('appointment_time', isLessThan: Timestamp.fromDate(endDate))
        .where('appointment_time', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('appointment_time', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<BookingModel>> getBookingsClinicMonth(
      DateTime startDate, DateTime endDate, String uid) {
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('clinic_uid', isEqualTo: uid)
        .where('appointment_time', isLessThan: Timestamp.fromDate(endDate))
        .where('appointment_time', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('appointment_time', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  }

  // static Stream<List<List<BookingModel>>> getBookingsPathologyMonth(
  //     DateTime startDate,DateTime endDate, String uid) {
  //   final q = FirebaseFirestore.instance
  //       .collection('bookings')
  //       .where('clinic_uid', isEqualTo: uid)
  //       .where('appointment_time', isLessThan: Timestamp.fromDate(endDate))
  //       .where('appointment_time', isGreaterThan: Timestamp.fromDate(startDate))
  //       .orderBy('appointment_time', descending: false).snapshots();
  //   return q.map((event) => event.docs.map((e) => BookingModel.fromJson(e.data(), e.id)).toList());
  // }

  static Future<DoOrDie> bookAppointment({
    required AppointmentModel appointment,
    required String fees,
    required Slot slot,
    required UserModel user,
    required String userUid,
    required String? transactionId,
    required String paymentTerms,
    required String paymentStatus,
    required ServicesModel? service,
    required List<BookingModel>? bookingSlots,
    required HealthPackageModel? healthPackageModel,
  }) async {
    try {
      final time = Timestamp.now().microsecondsSinceEpoch.toString();
      final paymentId = time + userUid;
      final payment = PaymentModel(
        id: paymentId,
        clinicUid: appointment.clinicUid,
        doctorUid: appointment.doctorId ?? "",
        transactionId: transactionId ?? "",
        reciverName: appointment.doctorName ?? "",
        bankName: "",
        bankIfsc: "",
        bankBranch: "",
        createdOn: Timestamp.now(),
        paidFor: 'Appointment',
        taxDeduction: '0',
        actualAmountRecived: fees,
        serviceCharge: '0',
        otherCharges: 'NA',
        otherChargesAmount: '0',
        notes: paymentTerms,
        paidBy: userUid,
        statusCode: paymentStatus,
        error: '',
        status: paymentStatus,
      );
      await GraphDataModel.addPaymentLog(payment.doctorUid, payment.id,
          payment.createdOn.toDate(), int.parse(payment.actualAmountRecived));
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(payment.id)
          .set(payment.toJson());
      if (bookingSlots != null) {
        List<BookingModel> doOrDie = [];
        final linkID = paymentId;
        final bSlots = bookingSlots.map((e) {
          final uid =
              "${Timestamp.now().microsecondsSinceEpoch}#${e.slotId.replaceAll(":", "")}";
          final verificationCode = math.Random(1000).nextInt(9999);
          return e.copyWith(
            uid: uid,
            slotId: e.slotId,
            bookingTime: e.slotId,
            patientName: user.name.toString(),
            patientDetails: "",
            userId: userUid,
            memberId: "0",
            appointmentType: BookingType.physiotherapy.toString(),
            appointmentDetails: "",
            verificationCode: "$verificationCode",
            fees: fees,
            statusCode: StatusCode.booked.toString(),
            paymentID: paymentId,
            prescriptionUrl: "",
            location: e.location,
            service: service,
            linkId: linkID,
          );
        }).toList();
        bSlots.forEach((element) async {
          await FirebaseFirestore.instance
              .collection('appointments')
              .where('uid', isEqualTo: element.appointmentId)
              .get()
              .then((value) async {
            final slotfee = int.parse(element.fees) / bookingSlots.length;
            final nSlot = Slot(id: element.slotId, fees: "$slotfee");
            final appoint = AppointmentModel.fromJson(
                value.docs.first.data(), value.docs.first.id);
            if (appoint.bookedSlots.where((bs) => bs.id == nSlot.id).isEmpty) {
              element.copyWith(statusCode: StatusCode.failed.toString());
            }
            final bookedSlots = appoint.bookedSlots + [nSlot];
            final app = appoint.copyWith(bookedSlots: bookedSlots);
            await FirebaseFirestore.instance
                .collection('appointments')
                .doc(app.id)
                .set(app.toJson());
            await FirebaseFirestore.instance
                .collection('bookings')
                .doc(element.uid)
                .set(element.toJson());
            await GraphDataModel.addBookingLog(element.doctorId, element.userId,
                nSlot.id, element.appointmentTime.toDate());
          });
        });
        await Future.delayed(const Duration(milliseconds: 500));
        log(doOrDie.map((e) => e.toString()).toString());
        if (doOrDie.isEmpty) {
          return DoOrDie(
            status: "Booked",
            message: "Successfully Booked !.",
            statusCode: StatusCode.success,
            bookings: doOrDie,
          );
        } else {
          return DoOrDie(
            status: "Booked",
            message: "Successfully Booked !..",
            statusCode: StatusCode.paid,
            bookings: doOrDie,
          );
        }
      } else {
        final uid = time + userUid;
        final verificationCode = math.Random(1000).nextInt(9999);
        final book = BookingModel(
          uid: uid,
          appointmentId: appointment.uid.toString(),
          appointmentLength: appointment.timeLimit,
          appointmentTime: appointment.date!,
          slotId: slot.id,
          bookingTime: slot.id,
          patientName: user.name.toString(),
          patientDetails: "",
          userId: userUid,
          memberId: "0",
          appointmentType: appointment.type.toString(),
          appointmentDetails: "",
          verificationCode: "$verificationCode",
          fees: fees,
          statusCode: StatusCode.booked.toString(),
          doctorId: appointment.doctorId!,
          medType: '',
          doctorName: appointment.doctorName ?? "",
          category: "",
          rebookID: '',
          paymentID: paymentId,
          prescriptionUrl: "",
          location: appointment.location,
          service: service,
          clinicUid: appointment.clinicUid,
          linkId: null,
          healthPackage: healthPackageModel,
        );
        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(book.uid)
            .set(book.toJson());
        final bookedSlots = appointment.bookedSlots + [slot];
        final app = appointment.copyWith(bookedSlots: bookedSlots);
        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointment.id)
            .set(app.toJson());
        await GraphDataModel.addBookingLog(book.doctorId, book.userId,
            book.slotId, book.appointmentTime.toDate());
        return DoOrDie(
          status: "Booked",
          message: "Successfully Booked !",
          statusCode: StatusCode.success,
          bookings: [],
        );
      }
    } catch (e) {
      log(e.toString());
      return DoOrDie(
        statusCode: StatusCode.failed,
        status: 'Failed',
        message: '$e',
        bookings: [],
      );
    }
  }

  BookingModel copyWith({
    String? uid,
    String? appointmentId,
    String? doctorId,
    Timestamp? appointmentTime,
    String? slotId,
    String? bookingTime,
    String? patientName,
    String? patientDetails,
    String? userId,
    String? memberId,
    String? appointmentType,
    String? appointmentDetails,
    String? verificationCode,
    String? fees,
    String? statusCode,
    String? paymentID,
    String? doctorName,
    String? category,
    String? medType,
    String? rebookID,
    String? prescriptionUrl,
    LocationModel? location,
    ServicesModel? service,
    String? clinicUid,
    String? linkId,
    String? appointmentLength,
    HealthPackageModel? healthPackage,
  }) {
    return BookingModel(
      uid: uid ?? this.uid,
      appointmentId: appointmentId ?? this.appointmentId,
      doctorId: doctorId ?? this.doctorId,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      slotId: slotId ?? this.slotId,
      bookingTime: bookingTime ?? this.bookingTime,
      patientName: patientName ?? this.patientName,
      patientDetails: patientDetails ?? this.patientDetails,
      userId: userId ?? this.userId,
      memberId: memberId ?? this.memberId,
      appointmentType: appointmentType ?? this.appointmentType,
      appointmentDetails: appointmentDetails ?? this.appointmentDetails,
      verificationCode: verificationCode ?? this.verificationCode,
      fees: fees ?? this.fees,
      statusCode: statusCode ?? this.statusCode,
      paymentID: paymentID ?? this.paymentID,
      doctorName: doctorName ?? this.doctorName,
      category: category ?? this.category,
      medType: medType ?? this.medType,
      rebookID: rebookID ?? this.rebookID,
      prescriptionUrl: prescriptionUrl ?? this.prescriptionUrl,
      location: location ?? this.location,
      service: service ?? this.service,
      clinicUid: clinicUid ?? this.clinicUid,
      linkId: linkId ?? this.linkId,
      appointmentLength: appointmentLength ?? this.appointmentLength,
      healthPackage: healthPackage ?? this.healthPackage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
