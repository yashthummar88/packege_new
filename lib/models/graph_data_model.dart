// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class GraphDataModel {
  GraphDataModel({
    required this.previousMonthPayment,
    required this.previousMonthBooking,
    required this.previousMonthAppointment,
    required this.previousMonthSlots,
    required this.previousMonthId,
    required this.currentMonthPayment,
    required this.currentMonthBooking,
    required this.currentMonthAppointment,
    required this.currentMonthSlots,
    required this.currentMonthId,
    required this.currentMonthData,
  });
  late final int previousMonthPayment;
  late final int previousMonthBooking;
  late final int previousMonthAppointment;
  late final int previousMonthSlots;
  late final int previousMonthId;
  late final int currentMonthPayment;
  late final int currentMonthBooking;
  late final int currentMonthAppointment;
  late final int currentMonthSlots;
  late final int currentMonthId;
  late final CurrentMonthData currentMonthData;

  static Future<void> addBookingLog(
    String docUid,
    String userId,
    String slotId,
    DateTime date, {
    bool isCanceled = false,
  }) async {
    final int dayId = date.day;
    final int monthId = date.month;
    final int yearId = date.year;
    final BookDataList data = BookDataList(
      slotId: slotId,
      userId: userId,
      isCanceled: isCanceled,
      day: dayId,
    );
    await FirebaseDatabase.instance
        .ref('graph_data_admin')
        .child("$yearId")
        .child("$monthId")
        .child('book_data')
        .child("$dayId")
        .set(data.toJson());
    await FirebaseDatabase.instance
        .ref('graph_data')
        .child(docUid)
        .child("$yearId")
        .child("$monthId")
        .child('book_data')
        .child("$dayId")
        .set(data.toJson());
  }

  static Future<void> addAppointmentLog(
    String docId,
    String appoId,
    DateTime date,
    int totalSlot,
  ) async {
    final int dayId = date.day;
    final int monthId = date.month;
    final int yearId = date.year;
    final AppoDataList data = AppoDataList(
      docId: docId,
      appoId: appoId,
      day: dayId,
      totalSlot: totalSlot,
    );
    await FirebaseDatabase.instance
        .ref('graph_data_admin')
        .child("$yearId")
        .child("$monthId")
        .child('appointment_data')
        .child("$dayId")
        .set(data.toJson());
    await FirebaseDatabase.instance
        .ref('graph_data')
        .child(docId)
        .child("$yearId")
        .child("$monthId")
        .child('appointment_data')
        .child("$dayId")
        .set(data.toJson());
  }

  static Future<void> addPaymentLog(
    String docId,
    String paymentId,
    DateTime date,
    int amount,
  ) async {
    final int dayId = date.day;
    final int monthId = date.month;
    final int yearId = date.year;
    final PaymentDataList data = PaymentDataList(
      docId: docId,
      paymentId: paymentId,
      amount: amount,
      day: dayId,
    );
    await FirebaseDatabase.instance
        .ref('graph_data_admin')
        .child("$yearId")
        .child("$monthId")
        .child('payment_data')
        .child("$dayId")
        .set(data.toJson());
    await FirebaseDatabase.instance
        .ref('graph_data')
        .child(docId)
        .child("$yearId")
        .child("$monthId")
        .child('payment_data')
        .child("$dayId")
        .set(data.toJson());
  }

  static Future<GraphDataModel?> getGraphData(
      DateTime date, String docUid) async {
    final int yearId = date.year;
    final int monthId = date.month;
    final gData = await FirebaseDatabase.instance
        .ref('graph_data')
        .child(docUid)
        .child("$yearId")
        .child("$monthId")
        .get();
    final gDataLastMonth = await FirebaseDatabase.instance
        .ref('graph_data_backup')
        .child(docUid)
        .child("$yearId")
        .child("$monthId")
        .get();
    final graphDataBackUp = gDataLastMonth.value != null
        ? (gDataLastMonth.value as Map<String, dynamic>)
        : {};
    final graphData = gData.value != null ? (gData.value as Map<String, dynamic>) : null;
    if (graphData != null) {
      final data = CurrentMonthData.fromJson(graphData);
      final previousMonthPayment = graphDataBackUp['previous_month_payment'] ?? 0;
      final previousMonthBooking = graphDataBackUp['previous_month_booking'] ?? 0;
      final previousMonthAppointment = graphDataBackUp['previous_month_appointment'] ?? 0;
      final previousMonthSlots = graphDataBackUp['previous_month_slots'] ?? 0;
      final previousMonthId = date.subtract(const Duration(days: 30)).month;
      final currentMonthPayment = data.paymentDataList.fold<int>(0, (previousValue, element) => previousValue + element.amount);
      final currentMonthBooking = data.bookDataList.length;
      final currentMonthAppointment = data.appoDataList.length;
      final currentMonthSlots = data.appoDataList.fold<int>(0, (previousValue, element) => previousValue + element.totalSlot);
      final currentMonthId = date.month;
      return GraphDataModel(
        previousMonthPayment: previousMonthPayment,
        previousMonthBooking: previousMonthBooking,
        previousMonthAppointment: previousMonthAppointment,
        previousMonthSlots: previousMonthSlots,
        previousMonthId: previousMonthId,
        currentMonthPayment: currentMonthPayment,
        currentMonthBooking: currentMonthBooking,
        currentMonthAppointment: currentMonthAppointment,
        currentMonthSlots: currentMonthSlots,
        currentMonthId: currentMonthId,
        currentMonthData: data,
      );
    }else{
      final data = CurrentMonthData.demo();
      final previousMonthPayment = graphDataBackUp['previous_month_payment'] ?? 0;
      final previousMonthBooking = graphDataBackUp['previous_month_booking'] ?? 0;
      final previousMonthAppointment = graphDataBackUp['previous_month_appointment'] ?? 0;
      final previousMonthSlots = graphDataBackUp['previous_month_slots'] ?? 0;
      final previousMonthId = date.subtract(const Duration(days: 30)).month;
      final currentMonthPayment = data.paymentDataList.fold<int>(0, (previousValue, element) => previousValue + element.amount);
      final currentMonthBooking = data.bookDataList.length;
      final currentMonthAppointment = data.appoDataList.length;
      final currentMonthSlots = data.appoDataList.fold<int>(0, (previousValue, element) => previousValue + element.totalSlot);
      final currentMonthId = date.month;
      return GraphDataModel(
        previousMonthPayment: previousMonthPayment,
        previousMonthBooking: previousMonthBooking,
        previousMonthAppointment: previousMonthAppointment,
        previousMonthSlots: previousMonthSlots,
        previousMonthId: previousMonthId,
        currentMonthPayment: currentMonthPayment,
        currentMonthBooking: currentMonthBooking,
        currentMonthAppointment: currentMonthAppointment,
        currentMonthSlots: currentMonthSlots,
        currentMonthId: currentMonthId,
        currentMonthData: data,
      );
    }
  }

  GraphDataModel.fromJson(Map<String, dynamic> json) {
    previousMonthPayment = json['previous_month_payment'];
    previousMonthBooking = json['previous_month_booking'];
    previousMonthAppointment = json['previous_month_appointment'];
    previousMonthSlots = json['previous_month_slots'];
    previousMonthId = json['previous_month_id'];
    currentMonthPayment = json['current_month_payment'];
    currentMonthBooking = json['current_month_booking'];
    currentMonthAppointment = json['current_month_appointment'];
    currentMonthSlots = json['current_month_slots'];
    currentMonthId = json['current_month_id'];
    currentMonthData = json['current_month_data']!=null?CurrentMonthData.fromJson(json['current_month_data'] as Map<String, dynamic>):CurrentMonthData.demo();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['previous_month_payment'] = previousMonthPayment;
    data['previous_month_booking'] = previousMonthBooking;
    data['previous_month_appointment'] = previousMonthAppointment;
    data['previous_month_slots'] = previousMonthSlots;
    data['previous_month_id'] = previousMonthId;
    data['current_month_payment'] = currentMonthPayment;
    data['current_month_booking'] = currentMonthBooking;
    data['current_month_appointment'] = currentMonthAppointment;
    data['current_month_slots'] = currentMonthSlots;
    data['current_month_id'] = currentMonthId;
    data['current_month_data'] = currentMonthData.toJson();
    return data;
  }
}

class CurrentMonthData {
  CurrentMonthData({
    required this.bookDataList,
    required this.paymentDataList,
    required this.appoDataList,
  });
  late final List<BookDataList> bookDataList;
  late final List<AppoDataList> appoDataList;
  late final List<PaymentDataList> paymentDataList;

  CurrentMonthData.fromJson(Map<String, dynamic> json) {
    final list = List.generate(31, (index) => index + 1).toList();
    list.forEach((index) {
      final book = json['book_data_list']['$index'] as Map<String, dynamic>?;
      bookDataList.add(book != null
          ? BookDataList.fromJson(book, index)
          : BookDataList.demo(index));
    });
    list.forEach((index) {
      final appo = json['appo_data_list']['$index'] as Map<String, dynamic>?;
      appoDataList.add(appo != null
          ? AppoDataList.fromJson(appo, index)
          : AppoDataList.demo(index));
    });
    list.forEach((index) {
      final payment = json['payment_data_list']['$index'] as Map<String, dynamic>?;
      paymentDataList.add(payment != null
          ? PaymentDataList.fromJson(payment, index)
          : PaymentDataList.demo(index));
    });
  }
  CurrentMonthData.demo(){
    final list = List.generate(31, (index) => index + 1).toList();
    list.forEach((index) {
      bookDataList.add(BookDataList.demo(index));
    });
    list.forEach((index) {
      appoDataList.add(AppoDataList.demo(index));
    });
    list.forEach((index) {
      paymentDataList.add(PaymentDataList.demo(index));
    });
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['book_data_list'] = bookDataList.map((e) => e.toJson()).toList();
    data['appo_data_list'] = appoDataList.map((e) => e.toJson()).toList();
    data['payment_data_list'] =
        paymentDataList.map((e) => e.toJson()).toList();
    return data;
  }
}

class AppoDataList {
  AppoDataList({
    required this.day,
    required this.appoId,
    required this.docId,
    required this.totalSlot,
  });
  late final int day;
  late final String appoId;
  late final String docId;
  late final int totalSlot;

  AppoDataList.fromJson(Map<String, dynamic> json, int dayi) {
    day = dayi;
    appoId = json['appo_id'];
    docId = json['doc_id'];
    totalSlot = json['total_slot'];
  }

  AppoDataList.demo(int dayi) {
    day = dayi;
    appoId = "";
    docId = "";
    totalSlot = 0;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['appo_id'] = appoId;
    map['doc_id'] = docId;
    map['total_slot'] = totalSlot;
    return map;
  }
}

class PaymentDataList {
  PaymentDataList({
    required this.day,
    required this.paymentId,
    required this.docId,
    required this.amount,
  });
  late final int day;
  late final String paymentId;
  late final String docId;
  late final int amount;

  PaymentDataList.fromJson(Map<String, dynamic> json, int dayi) {
    day = dayi;
    paymentId = json['payment_id'];
    docId = json['doc_id'];
    amount = json['amount'];
  }
  PaymentDataList.demo(int dayi) {
    day = dayi;
    paymentId = "";
    docId = "";
    amount = 0;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['payment_id'] = paymentId;
    map['doc_id'] = docId;
    map['amount'] = amount;
    return map;
  }
}

class BookDataList {
  BookDataList({
    required this.day,
    required this.slotId,
    required this.userId,
    required this.isCanceled,
  });
  late final int day;
  late final String slotId;
  late final String userId;
  late final bool isCanceled;

  BookDataList.fromJson(Map<String, dynamic> json, int dayi) {
    day = dayi;
    slotId = json['slot_id'];
    userId = json['user_id'];
    isCanceled = json['is_canceled'];
  }
  BookDataList.demo(int dayi) {
    day = dayi;
    slotId = "";
    userId = "";
    isCanceled = false;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['slot_id'] = slotId;
    map['user_id'] = userId;
    map['is_canceled'] = isCanceled;
    return map;
  }
}

extension Sebayet on dynamic {
  List<Map<String, dynamic>> toListOfMap() {
    if (this != null) {
      return (this as List)
          .map((e) => jsonDecode(jsonEncode(e)) as Map<String, dynamic>)
          .toList();
    }
    return <Map<String, dynamic>>[];
  }

  Map<int, Map<String, dynamic>> toMapOfMap() {
    if (this != null) {
      final data = (this as Map<String, Map<String, dynamic>>)
          .map((key, value) => MapEntry(int.parse(key), value));
      return data;
    }
    return {};
  }
}
