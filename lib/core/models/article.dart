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

  ///Publishing date of the aricle
  DateTime publishedDate;

  ///List of images related to the article
  List<ArticleMultimedia> articleMultimedia;

  Article({
    this.title,
    this.section,
    this.abstractText,
    this.url,
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

  ///Convert an article to json
  Map<String, dynamic> toJson() => {
        'title': title,
        'section': section,
        'abstract': abstractText,
        'url': url,
        'published_date': publishedDate?.toString(),
        'multimedia': ArticleMultimedia.toJsonList(articleMultimedia),
      };

  ///Convert a list of articles to json
  static List<Map<String, dynamic>> toJsonList(List<Article> articles) {
    List<Map<String, dynamic>> json =
        articles.map((article) => article.toJson()).toList();
    return json;
  }
}
