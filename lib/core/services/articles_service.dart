import 'package:top_stories/core/core.dart';

class ArticlesService {
  Future<Articles> getArticles() {
    return Network.get(API.world).then((res) => Articles.fromJson(res));
  }
}
