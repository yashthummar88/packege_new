enum UserType {
  doctor,
  clinic,
  user,
  physiotherapy,
  pathology,
  b2bUnknown,
  veterinary,
  admin,
  support,
}

enum DoctorType {
  homeopathy,
  allopathic,
  ayurvedic,
}

enum BookingType {
  videoCall,
  clinicVisit,
  doctorVisit,
  pathology,
  physiotherapy,
}

enum StatusCode {
  booked,
  otpVerified,
  completed,
  canceled,
  success,
  failed,
  paid,
  notPaid,
  paymentPending,
  pending,
  missed,
}
