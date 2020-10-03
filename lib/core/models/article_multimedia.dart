import 'package:top_stories/core/core.dart';

class ArticleMultimedia {
  ///The url to retrieve the image
  String url;

  ///The display type of the image (Small, medium, large, etc)
  ArticleImageSize imageSize;

  ArticleMultimedia({
    this.url,
    this.imageSize,
  });

  factory ArticleMultimedia.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return ArticleMultimedia(
        url: json['url'] != null ? json['url'] : null,
        imageSize:
            json['format'] != null ? ArticleImageSize(json['format']) : null,
      );
    } else {
      return null;
    }
  }

  static List<ArticleMultimedia> fromJsonList(List json) {
    if (json != null && json.isNotEmpty) {
      List<ArticleMultimedia> multimedia = json
          .map((multimedia) => ArticleMultimedia.fromJson(multimedia))
          .toList();
      return multimedia;
    } else {
      return [];
    }
  }
}
