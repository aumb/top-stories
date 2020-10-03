import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_stories/core/core.dart';

class StorageManager {
  _MobileStorage storage;

  StorageManager() {
    storage = _MobileStorage();
  }

  ///Use to save the bookmarked articles on the device.
  ///We iterate over the articles provided, convert them to json
  ///and then add them to the storage.
  ///
  ///Used for both adding and removing bookmarks
  Future<bool> saveBookmarks(List<Article> articles) async {
    List<Article> _articles = [];
    for (var article in articles) {
      _articles.add(article);
    }
    print(Article.toJsonList(_articles));
    return storage.setJson('articles', Article.toJsonList(_articles));
  }

  ///Get all the bookmarks and parse them.
  Future<List<Article>> getBookmarks() async {
    var json = await storage.getJson('articles');
    return json != null ? Article.fromJsonList(json) : [];
  }
}

class _MobileStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  ///Write a key value pair to the database
  Future<bool> setString(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///get a key value pair to the database
  Future<String> getString(String key) async {
    String value = await storage.read(key: key);
    return value;
  }

  ///Get json and decode in order to parse it later
  Future<Object> getJson(String key) async {
    String value = await getString(key);
    return isNotEmpty(value) ? json.decode(value) : null;
  }

  ///Set json and encode
  Future<bool> setJson(String key, Object object) async {
    return setString(key, json.encode(object));
  }
}
