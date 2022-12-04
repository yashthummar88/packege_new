import 'package:sebayet_package/enums/enums.dart';
import 'package:sebayet_package/models/booking_model.dart';

class DoOrDie {
  final String status;
  final String message;
  final StatusCode statusCode;
  final List<BookingModel> bookings;
  DoOrDie({required this.status, required this.message, required this.statusCode,required this.bookings,});

  DoOrDie copyWith({
    String? status,
    String? message,
    StatusCode? statusCode,
    List<BookingModel>? bookings,
  }) {
    return DoOrDie(
      status: status ?? this.status,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      bookings: bookings ?? this.bookings,
    );
  }
}
