class ServicesFeesMap {
  ServicesFeesMap({
    required this.service,
    required this.fees,
    required this.discount,
    required this.couponCodes,
  });
  late final String service;
  late final String fees;
  late final String discount;
  late final List<String> couponCodes;

  ServicesFeesMap.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    fees = json['fees'];
    discount = json['discount'];
    couponCodes =
        (json['coupon_codes'] as List).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['service'] = service;
    _data['fees'] = fees;
    _data['discount'] = discount;
    _data['coupon_codes'] = couponCodes;
    return _data;
  }

  ServicesFeesMap copyWith({
    String? service,
    String? fees,
    String? discount,
    List<String>? couponCodes,
  }) {
    return ServicesFeesMap(
      service: service ?? this.service,
      fees: fees ?? this.fees,
      discount: discount ?? this.discount,
      couponCodes: couponCodes ?? this.couponCodes,
    );
  }
}
