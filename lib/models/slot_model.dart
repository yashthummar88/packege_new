class Slot {
  Slot({
    required this.id,
    required this.fees,
  });
  late final String id;
  late final String fees;

  Slot.fromJson(Map<String, dynamic> json){
    id = json['id'] as String;
    fees = json['fees'] as String;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Slot && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fees'] = fees;
    return _data;
  }
}