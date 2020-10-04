import 'package:rxdart/rxdart.dart';
import 'package:top_stories/core/core.dart';

class ArticleController {
  final Article article;
  BehaviorSubject<bool> _refresh;

  ArticleController(this.article) {
    _refresh = BehaviorSubject<bool>.seeded(false);
  }

  //Stream getters
  Stream<bool> get refreshStream => _refresh.stream;

  //Value getters
  bool get refresh => _refresh.value;

  //Value setters
  set refresh(bool value) {
    if (!_refresh.isClosed) _refresh.add(value);
  }

  ///Check if the article is bookmarked
  bool isBookmarked() {
    bool isFavorite = false;
    Article _article = BookmarkController().articles.firstWhere(
        (element) => element.url == article.url,
        orElse: () => null);
    if (_article != null) {
      isFavorite = true;
    }
    return isFavorite;
  }

  void dispose() {
    if (!_refresh.isClosed) _refresh.close();
  }
}
