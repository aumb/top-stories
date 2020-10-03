import 'package:rxdart/rxdart.dart';
import 'package:top_stories/core/core.dart';

class ArticleController {
  final Article article;
  BehaviorSubject<bool> _isLoading;

  ArticleController(this.article) {
    _isLoading = BehaviorSubject<bool>.seeded(false);
  }

  //Stream getters
  Observable<bool> get isLoadingStream => _isLoading.stream;

  //Value getters
  bool get isLoading => _isLoading.value;

  //Value setters
  set isLoading(bool value) {
    if (!_isLoading.isClosed) _isLoading.add(value);
  }

  ///Check if the article is bookmarked
  bool isFavorite() {
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
    if (!_isLoading.isClosed) _isLoading.close();
  }
}
