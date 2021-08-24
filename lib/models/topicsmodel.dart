import 'package:picsplash/models/imagemodel.dart';
/// Model for Explore Page
class TopicsModel {
  final String title;
  final String slug;
  ImageModel coverPhoto;

  TopicsModel(
      {required this.title, required this.slug, required this.coverPhoto});

  factory TopicsModel.fromJson(Map<String, dynamic> json) {
    return TopicsModel(
        title: json['title'],
        slug: json['slug'],
        coverPhoto: ImageModel.fromJson(json["cover_photo"]));
  }
}
