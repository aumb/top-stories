import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:top_stories/core/core.dart';

class Network {
  static Logger _netowrkLogger = Logger(
    printer: PrettyPrinter(),
  );

  static Dio client;

  static Map<String, dynamic> queryParameters = {};

  static BaseOptions options = new BaseOptions(
    baseUrl: API.host,
    queryParameters: queryParameters,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );

  static Future<dynamic> get(String path,
      {ResponseType responseType, Map<String, String> headers}) async {
    if (responseType != null) {
      client.options.responseType = responseType;
    } else {
      client.options.responseType = ResponseType.json;
    }
    Response response = await client.get(path);
    if (responseType != ResponseType.bytes) {
      _netowrkLogger.d(response.data);
    }
    return response.data;
  }

  init() {
    _setUpDio();
  }

  void _setUpDio() {
    queryParameters['key'] = API.KEY;
    client = Dio(options);
  }
}
