import 'package:rxdart/rxdart.dart';
import 'package:top_stories/core/core.dart';

class ArticlesController {
  ///Used for displaying the application loader
  BehaviorSubject<PageState> _pageState;

  ///Used for tracking the list of articles
  BehaviorSubject<Articles> _articles;

  ArticlesService _service;

  ///Intiialize behavior subjects
  ArticlesController() {
    _pageState = BehaviorSubject<PageState>.seeded(null);
    _articles = BehaviorSubject<Articles>.seeded(null);

    _service = ArticlesService();
  }

  //Stream getters
  Observable<PageState> get pageStateStream => _pageState.stream;
  Observable<Articles> get articlesStream => _articles.stream;

  //Stream Combiners
  Observable<bool> get combinedStream => Observable.combineLatest2(
        pageStateStream,
        articlesStream,
        (a, b) => true,
      );

  //Value getters
  PageState get pageState => _pageState.value;
  Articles get articles => _articles.value;

  //Value setters
  set pageState(PageState value) {
    if (!_pageState.isClosed) _pageState.add(value);
  }

  set articles(Articles value) {
    if (!_articles.isClosed) _articles.add(value);
  }

  //Future functions

  ///A call to get the articles, if is refresh is flase the pagestate is not manipulated
  ///thus we can maintain the current UI
  Future<void> getArticles({bool isRefresh = false}) {
    if (!isRefresh) pageState = PageState.loading;

    return _service.getArticles().then((value) {
      articles = value;
      if (!isRefresh) pageState = PageState.loaded;
    }).catchError((e) {
      print(e);
      if (!isRefresh) pageState = PageState.error;
    });
  }

  //Functions
  void dispose() {
    if (!_pageState.isClosed) _pageState.close();
    if (!_articles.isClosed) _articles.close();
  }
}
