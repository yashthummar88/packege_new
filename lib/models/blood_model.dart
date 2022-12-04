class BloodComponentModel {
  BloodComponentModel({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodComponentModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class BloodModel {
  BloodModel({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  BloodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }

  static Map<dynamic, String> bloods = {
    18: "AB-Ve",
    17: "AB+Ve",
    12: "A-Ve",
    11: "A+Ve",
    14: "B-Ve",
    13: "B+Ve",
    23: "Oh-VE",
    22: "Oh+VE",
    16: "O-Ve",
    15: "O+Ve",
    "all": "All Blood Group"
  };
  static List<BloodComponentModel> bloodComponentList = [
    {-1: "Select Blood Component"},
    {11: "Whole Blood"},
    {14: "Single Donor Platelet"},
    {18: "Single Donor Plasma"},
    {28: "Sagm Packed Red Blood Cells"},
    {16: "Platelet Rich Plasma"},
    {15: "Platelet Poor Plasma"},
    {20: "Platelet Concentrate"},
    {19: "Plasma"},
    {12: "Packed Red Blood Cells"},
    {30: "Leukoreduced Rbc"},
    {29: "Irradiated RBC"},
    {13: "Fresh Frozen Plasma"},
    {17: "Cryoprecipitate"},
    {21: "Cryo Poor Plasma"}
  ]
      .map(
        (e) => BloodComponentModel(
          id: e.keys.first.toString(),
          name: e.values.first.toString(),
        ),
      )
      .toList();

  static List<BloodModel> list() => bloods.entries
      .map(
        (e) => BloodModel(
          id: e.key.toString(),
          name: e.value.toString(),
        ),
      )
      .toList();
}
