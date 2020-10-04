import 'package:rxdart/rxdart.dart';
import 'package:top_stories/core/core.dart';
import 'package:top_stories/core/managers/storage_manager.dart';

class BookmarkController {
  StorageManager _storageManager;

  ///Used for tracking the list of bookedmarked articles across the app
  BehaviorSubject<List<Article>> _articles;

  ///Build the UI based on this state
  PageState _pageState;

  static final BookmarkController _instance = BookmarkController._internal();

  BookmarkController._internal() {
    _storageManager = StorageManager();
    _articles = BehaviorSubject<List<Article>>.seeded(_articles?.value ?? []);
  }

  factory BookmarkController() {
    return _instance;
  }

  //Stream getters
  Stream<List<Article>> get articlesStream => _articles.stream;

  //Value getters
  List<Article> get articles => _articles.value;
  PageState get pageState => _pageState;

  //Value setters
  set articles(List<Article> value) {
    if (!_articles.isClosed) _articles.add(value);
  }

  //Future functions

  ///To bookmark an article, first we check if it the article
  ///is bookmarked. After that if the article isn't bookmarked
  ///we add it to the device storage, while if it's bookmared we
  ///return an error
  Future<void> bookmarkArticle(Article article) async {
    Article _article = articles?.firstWhere(
      (element) => element.url == article.url,
      orElse: () => null,
    );

    if (_article == null) {
      articles.add(article);
      return _storageManager
          .saveBookmarks(articles)
          .then((value) => getBookmarkedArticles());
    } else {
      _pageState = PageState.error;
    }
  }

  ///To remove an article from the book marks, first we check if it the article
  ///is bookmarked. After that if the article is bookmarked
  ///we remove it from the device storage, while if it's not bookmared we
  ///return an error
  Future<void> removeBookmarkedArticle(Article article) async {
    Article _article = articles?.firstWhere(
      (element) => element.url == article.url,
      orElse: () => null,
    );

    if (_article != null) {
      int articleIndex =
          articles.indexWhere((element) => element.url == article.url);
      articles.removeAt(articleIndex);
      return _storageManager
          .saveBookmarks(articles)
          .then((value) => getBookmarkedArticles());
    } else {
      _pageState = PageState.error;
    }
  }

  //Future functions

  ///Get all the bookmarked articles on the phone
  Future<void> getBookmarkedArticles() {
    return _storageManager.getBookmarks().then((value) {
      print("got articles");
      articles = [];
      articles.addAll(value);
      articles = articles;
    });
  }

  //Functions
  void dispose() {
    if (!_articles.isClosed) _articles.close();
  }
}
