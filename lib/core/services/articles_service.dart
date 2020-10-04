import 'package:top_stories/core/core.dart';

class ArticlesService {
  ///Get articles from api then return their parsed value
  Future<Articles> getArticles() {
    return Network.get(API.world).then((res) => Articles.fromJson(res));
  }
}
