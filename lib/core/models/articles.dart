import 'package:top_stories/core/core.dart';

class Articles {
  ///Status of the request
  String status;

  ///Copyright statement of NYT
  String copyright;

  ///Section of the delivered request
  String section;

  ///Last time the results got updated
  DateTime lastUpdated;

  ///Number of results retrieved
  num resultsNumber;

  ///List of articles retrieved
  List<Article> results;

  Articles({
    this.status,
    this.copyright,
    this.section,
    this.lastUpdated,
    this.resultsNumber,
    this.results,
  });

  ///Parses the main API body object
  factory Articles.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Articles(
        status: json['status'] != null ? json['status'] : null,
        copyright: json['copyright'] != null ? json['copyright'] : null,
        section: json['section'] != null ? json['section'] : null,
        lastUpdated: json['last_updated'] != null
            ? DateTime.tryParse(json['last_updated'])
            : null,
        resultsNumber: json['num_results'] != null ? json['num_results'] : null,
        results: json['results'] != null
            ? Article.fromJsonList(json['results'])
            : null,
      );
    } else {
      return null;
    }
  }
}
