import 'package:dio/dio.dart';
import 'HttpPath.dart';
import 'HttpRequest.dart';

Dio dio;

class HttpAPI {

  static Future request(HttpRequest request) async {
    if (dio == null) {
      dio = Dio();
    }

    if (request.rootUrl == null || request.rootUrl.isEmpty) {
      print('-----------------rootUrl is null-----------------');
//      return;
    }
    dio.options.baseUrl = HttpPath.rootURL ?? '';

    if (request.path == null || request.path.isEmpty) {
      print('-----------------path is null-----------------');
    }

    if(request.isHaveToken) {
      if (request.token == null || request.token.isEmpty) {
        print('-----------------token is null-----------------');
      }
      dio.options.headers = {
        'Authentication': request.token ?? '',
      };
    }

    try {

    } catch(e) {
      print(e);
    }

    var response;
    switch(request.method) {
      case Method.Get:
        response = await dio.get(request.path, queryParameters: request.param);
        break;

      case Method.Post:
        response = await dio.post(request.path, data: request.param, queryParameters: request.unGetMethodQueryParam ?? {});
        break;

      case Method.Put:
        response = await dio.put(request.path, data: request.param);
        break;

      case Method.Delete:
        response = await dio.delete(request.path, data: request.param);
        break;
    }
    return response.data;

  }


}