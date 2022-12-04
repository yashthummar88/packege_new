class FeedbackModel {
  FeedbackModel({
    required this.name,
    required this.image,
    required this.feedback,
    required this.ratting,
    required this.doctorId,
    required this.userId,
  });
  late final String name;
  late final String image;
  late final String feedback;
  late final int ratting;
  late final String doctorId;
  late final String userId;

  FeedbackModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    image = json['image'];
    feedback = json['feedback'];
    ratting = json['ratting'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['image'] = image;
    _data['feedback'] = feedback;
    _data['ratting'] = ratting;
    _data['doctor_id'] = doctorId;
    _data['user_id'] = userId;
    return _data;
  }
}