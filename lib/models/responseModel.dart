class responseModel {

  bool status;
  String message;

  responseModel({
    required this.status,
    required this.message
  });

  factory responseModel.fromJson(Map<String, dynamic> json) {
    return responseModel(
        status: json['status'] as bool,
        message: json['message'] as String,
    );
  }
}
