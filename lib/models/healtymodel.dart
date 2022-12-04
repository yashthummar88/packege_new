// ignore_for_file: public_member_api_docs, sort_constructors_first
class HealthModel {
  String name;
  double lat;
  double long;
  int age;
  String gender;

  String activityLevel;
  double height;
  double currWeight;
  double targetWeight;
  double lossWeighttarget;
  List<String> disease;
  List<String> services;
  HealthModel({
    required this.name,
    required this.lat,
    required this.long,
    required this.age,
    required this.gender,
    required this.activityLevel,
    required this.height,
    required this.currWeight,
    required this.targetWeight,
    required this.lossWeighttarget,
    required this.disease,
    required this.services,
  });

  

/*
  HealthModel.fromJson(Map<String, dynamic> json) {
    print(json);
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
    age = json['age'];
    gender = json['gender'];
    height = json['height'];
    activityLevel = json['activityLevel'];
    currWeight = json['currWeight'];
    targetWeight = json['targetWeight'];
    lossWeighttarget = json['lossWeighttarget'];

    disease = [];
    if (json['disease'] != null) {
      json['disease'].forEach((v) {
        disease.add(v.toString());
      });
    }
    services = [];
    if (json['services'] != null) {
      json['services'].forEach((v) {
        disease.add(v.toString());
      });
    }
  }
  HealthModel.fromDocument(DocumentSnapshot json) {
    name = json.data().toJson()['name'];
    location = json.data().toJson()['location'];
    age = json.data().toJson()['age'];
    gender = json.data().toJson()['gender'] ;
    height = json.data().toJson()['height'] ;
    activityLevel = json.data().toJson()['activityLevel'] ;
    currWeight = json.data().toJson()['currWeight'];
    targetWeight = json.data().toJson()['targetWeight'];
    lossWeighttarget = json.data().toJson()['lossWeighttarget'];
  
    services = [];
    if (json.data().toJson()['services'] != null) {
      json.data().toJson()['services'].forEach((v) {
        services.add(v.toString());
      });
    }

    disease = [];
    if (json.data().toJson()['disease'] != null) {
      json.data().toJson()['disease'].forEach((v) {
        disease.add(v.toString());
      });
    }
  }
*/
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['age'] = age;
    data['lat'] = lat;
    data['long'] = long;
    data['gender'] = gender;
    data['height'] = height;
    data['activityLevel'] = activityLevel;
    data['currWeight'] = currWeight;
    data['targetWeight'] = targetWeight;
    data['lossWeighttarget'] = lossWeighttarget;
    data['services'] = services;
    data['disease'] = disease;

    return data;
  }
}
