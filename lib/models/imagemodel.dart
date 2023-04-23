import 'dart:convert';

class ImageModel {
  UrlModel urls;
  String id;

  ImageModel({required this.urls,required this.id});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      urls: UrlModel.fromJson(json['urls']),
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() => {
      "urls": urls.toJson(),
      "id": id
    };

  factory ImageModel.decode(String str) =>
      ImageModel.fromJson(json.decode(str));
  
  @override
  String toString() {
    return 'ImageModel{urls: $urls, id: $id}';
  }
}

class UrlModel {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  UrlModel(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.thumb});

  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb']
    );
  }

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
  };
  @override
  String toString() {
    return 'UrlModel{raw: $raw, full: $full, regular: $regular, small: $small, thumb: $thumb}';
  }
}
