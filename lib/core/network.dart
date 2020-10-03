import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:top_stories/core/core.dart';

class Network {
  ///This is for logging information on the console
  static Logger _netowrkLogger = Logger(
    printer: PrettyPrinter(),
  );

  ///the client we're using for the network processes
  static Dio _client;

  ///Map of query parameters to pass to the client
  static Map<String, dynamic> queryParameters = {};

  ///The initial options to pass to the network client
  static BaseOptions options = new BaseOptions(
    baseUrl: API.host,
    queryParameters: queryParameters,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );

  ///A modified get function for less code repetitivness
  static Future<dynamic> get(String path,
      {ResponseType responseType, Map<String, String> headers}) async {
    if (responseType != null) {
      _client.options.responseType = responseType;
    } else {
      _client.options.responseType = ResponseType.json;
    }
    Response response = await _client.get(path);
    if (responseType != ResponseType.bytes) {
      _netowrkLogger.d(response.data);
    }
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
