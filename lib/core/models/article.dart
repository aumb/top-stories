import 'package:top_stories/core/core.dart';

class Article {
  ///Title of the article
  String title;

  ///Section of the article
  String section;

  ///Abstract text of the article
  String abstractText;

  ///Url of the article
  String url;

  ///Last time the article was updated
  DateTime updatedDate;

  ///Publishing date of the aricle
  DateTime publishedDate;

  ///List of images related to the article
  List<ArticleMultimedia> articleMultimedia;

  Article({
    this.title,
    this.section,
    this.abstractText,
    this.url,
    this.updatedDate,
    this.publishedDate,
    this.articleMultimedia,
  });

  ///Parses an article object
  factory Article.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Article(
        title: json['title'] != null ? json['title'] : null,
        section: json['section'] != null ? json['section'] : null,
        abstractText: json['abstract'] != null ? json['abstract'] : null,
        url: json['url'] != null ? json['url'] : null,
        updatedDate: json['updated_date'] != null
            ? DateTime.tryParse(json['updated_date'])
            : null,
        publishedDate: json['published_date'] != null
            ? DateTime.tryParse(json['published_date'])
            : null,
        articleMultimedia: json['multimedia'] != null
            ? ArticleMultimedia.fromJsonList(json['multimedia'])
            : null,
      );
    } else {
      return null;
    }
  }

  ///Parses a list of article objects
  static List<Article> fromJsonList(List json) {
    if (json != null && json.isNotEmpty) {
      List<Article> articles =
          json.map((article) => Article.fromJson(article)).toList();
      return articles;
    } else {
      return [];
    }
  }
}
