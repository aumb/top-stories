import 'package:rxdart/rxdart.dart';
import 'package:top_stories/core/core.dart';

class ArticlesController {
  ///Used for displaying the application loader
  BehaviorSubject<bool> _isLoading;

  ///Used for tracking the list of articles
  BehaviorSubject<Articles> _articles;

  ArticlesService _service;

  ///Intiialize behavior subjects
  ArticlesController() {
    _isLoading = BehaviorSubject<bool>.seeded(false);
    _articles = BehaviorSubject<Articles>.seeded(null);

    _service = ArticlesService();
  }

  //Stream getters
  Observable<bool> get isLoadingStream => _isLoading.stream;
  Observable<Articles> get articlesStream => _articles.stream;

  //Stream Combiners
  Observable<bool> get combinedStream => Observable.combineLatest2(
        isLoadingStream,
        articlesStream,
        (a, b) => true,
      );

  //Value getters
  bool get isLoading => _isLoading.value;
  Articles get articles => _articles.value;

  //Value setters
  set isLoading(bool value) {
    if (!_isLoading.isClosed) _isLoading.add(value);
  }

  set articles(Articles value) {
    if (!_articles.isClosed) _articles.add(value);
  }

  //Future functions
  Future<void> getArticles() {
    isLoading = true;
    return _service.getArticles().then((value) {
      articles = value;
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      isLoading = true;
    });
  }

  //Functions
  void dispose() {
    if (!_isLoading.isClosed) _isLoading.close();
    if (!_articles.isClosed) _articles.close();
  }
}
