import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  late String id;
  late String doctorUid;
  late String? clinicUid;
  late String transactionId;
  late String reciverName;
  late String bankName;
  late String bankIfsc;
  late String bankBranch;
  late Timestamp createdOn;
  late String paidFor;
  late String taxDeduction;
  late String actualAmountRecived;
  late String serviceCharge;
  late String otherCharges;
  late String otherChargesAmount;
  late String notes;
  late String paidBy;
  late String status;
  late String statusCode;
  late String error;

  PaymentModel({
    required this.id,
    required this.doctorUid,
    required this.clinicUid,
    required this.transactionId,
    required this.reciverName,
    required this.bankName,
    required this.bankIfsc,
    required this.bankBranch,
    required this.createdOn,
    required this.paidFor,
    required this.taxDeduction,
    required this.actualAmountRecived,
    required this.serviceCharge,
    required this.otherCharges,
    required this.otherChargesAmount,
    required this.notes,
    required this.paidBy,
    required this.status,
    required this.statusCode,
    required this.error,
  });

  PaymentModel.fromJson(Map<String, dynamic> json, String _id) {
    id = _id;
    doctorUid = json['doctor_uid'];
    clinicUid = json['clinic_uid'];
    transactionId = json['transaction_id'];
    reciverName = json['reciver_name'];
    bankName = json['bank_name'];
    bankIfsc = json['bank_ifsc'];
    bankBranch = json['bank_branch'];
    createdOn = json['created_on'];
    paidFor = json['paid_for'];
    taxDeduction = json['tax_deduction'];
    actualAmountRecived = json['actual_amount_recived'];
    serviceCharge = json['service_charge'];
    otherCharges = json['other_charges'];
    otherChargesAmount = json['other_charges_amount'];
    notes = json['notes'];
    paidBy = json['paid_by'];
    error = json['error'];
    statusCode = json['status_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_uid'] = doctorUid;
    data['clinic_uid'] = clinicUid;
    data['transaction_id'] = transactionId;
    data['reciver_name'] = reciverName;
    data['bank_name'] = bankName;
    data['bank_ifsc'] = bankIfsc;
    data['bank_branch'] = bankBranch;
    data['created_on'] = createdOn;
    data['paid_for'] = paidFor;
    data['tax_deduction'] = taxDeduction;
    data['actual_amount_recived'] = actualAmountRecived;
    data['service_charge'] = serviceCharge;
    data['other_charges'] = otherCharges;
    data['other_charges_amount'] = otherChargesAmount;
    data['notes'] = notes;
    data['paid_by'] = paidBy;
    data['status'] = status;
    data['status_code'] = statusCode;
    data['error'] = error;
    return data;
  }

  static Stream<List<PaymentModel>> getClinicPayments(String uid) {
    final q = FirebaseFirestore.instance
        .collection('payments')
        .where('clinic_uid', isEqualTo: uid)
        .orderBy('created_on', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => PaymentModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<PaymentModel>> getPaymentsClinicMonth(
    DateTime startDate,
    DateTime endDate,
    String uid,
  ) {
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('clinic_id', isEqualTo: uid)
        .where('created_on', isLessThan: Timestamp.fromDate(endDate))
        .where('created_on', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('created_on', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => PaymentModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<PaymentModel>> getDoctorPayments(String uid) {
    final q = FirebaseFirestore.instance
        .collection('payments')
        .where('doctor_uid', isEqualTo: uid)
        .orderBy('created_on', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => PaymentModel.fromJson(e.data(), e.id)).toList());
  }

  static Stream<List<PaymentModel>> getPaymentsDoctorMonth(
    DateTime startDate,
    DateTime endDate,
    String uid,
  ) {
    final q = FirebaseFirestore.instance
        .collection('bookings')
        .where('doctor_uid', isEqualTo: uid)
        .where('created_on', isLessThan: Timestamp.fromDate(endDate))
        .where('created_on', isGreaterThan: Timestamp.fromDate(startDate))
        .orderBy('created_on', descending: false)
        .snapshots();
    return q.map((event) =>
        event.docs.map((e) => PaymentModel.fromJson(e.data(), e.id)).toList());
  }
}
