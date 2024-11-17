class version {
  String last_version;
  String last_min_version;
  String url_ios;
  String url_android;

  version(
      {required this.last_version,
        required this.last_min_version,
        required this.url_ios,
        required this.url_android
      });

  factory version.fromJson(Map<String, dynamic> json) {
    return version(
      last_version: json['last_version'] as String,
      last_min_version: json['last_min_version'] as String,
      url_ios: json['url_ios'] as String,
      url_android: json['url_android'] as String,
    );
  }
}