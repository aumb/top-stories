import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:top_stories/core/core.dart';

class Network {
  ///This is for logging information on the console
  static Logger _netowrkLogger = Logger(
    printer: PrettyPrinter(),
  );

  ///The client we're using for the network processes
  static Dio _client;

  ///Map of query parameters to pass to the client
  static Map<String, dynamic> queryParameters = {};

  ///The initial options to pass to the network client
  static BaseOptions options = new BaseOptions(
    baseUrl: API.host,
    queryParameters: queryParameters,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  ///A modified get function for less code repetitivness
  static Future<dynamic> get(
    String path, {
    ResponseType responseType,
    Map<String, String> headers,
    bool forceRefresh = false,
  }) async {
    //Check if the request is in cache
    CacheManager cacheManager = CacheManager();
    CacheObject cacheObject = cacheManager.checkIfCached(path);

    //Return the response from cache if it exists
    if (cacheObject != null) {
      return cacheObject.cachedResponse;
    }

    Response response = await _client.get(path);

    //Create the cache object based on the cache-control header. If the time retrieved is less than 60 seconds, hardcode it to 60
    int cacheTimeSeconds = 0;
    if (response.headers != null && response.headers['cache-control'] != null) {
      String cacheControl = response.headers.map['cache-control'].first;
      int x = int.tryParse(cacheControl.split("=").last);
      if (x != null) {
        if (x < 60) {
          cacheTimeSeconds = 60;
        } else {
          cacheTimeSeconds = x;
        }
      }
    }
    var now = new DateTime.now();
    var validUntil = now.add(Duration(seconds: cacheTimeSeconds));
    CacheObject newCacheObject = CacheObject(
      validUntil: validUntil,
      cachedResponse: response.data,
    );
    cacheManager.addToMap(path, newCacheObject);

    //Log the server response
    _netowrkLogger.d(response.data);

    return response.data;
  }

  ///Intializing the network manager
  init() {
    _setUpDio();
  }

  ///Setting up the initial query parameters and the client with its options
  void _setUpDio() {
    queryParameters['api-key'] = API.KEY;
    _client = Dio(options);
  }
}
