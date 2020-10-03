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

  ///Create an article multimedia from a json map
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

  ///Create an article multimedia list from a json map
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

  ///Covert an article multimedia to json
  Map<String, dynamic> toJson() => {
        'url': url,
        'format': imageSize?.value,
      };

  ///Covert a list of article multimedias to json
  static List<Map<String, dynamic>> toJsonList(
      List<ArticleMultimedia> multimedia) {
    List<Map<String, dynamic>> json =
        multimedia.map((multimedia) => multimedia.toJson()).toList();
    return json;
  }
}
