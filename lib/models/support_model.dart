class SupportModel {
  late String name;
  late String uid;

  SupportModel({required this.name, required this.uid});

  SupportModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['uid'] = uid;
    return data;
  }
}
