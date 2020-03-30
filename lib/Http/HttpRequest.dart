import 'HttpPath.dart';

enum Method {
  Post,
  Get,
  Put,
  Delete
}

class HttpRequest {

  String path;

  String rootUrl;
  bool isHaveToken;
  String token;
  Map<String, dynamic> param;
  Method method;
  Type modelType;
  Map<String, dynamic> unGetMethodQueryParam;

  HttpRequest(this.path, {
    this.rootUrl = HttpPath.rootURL,
    this.isHaveToken = false,
    this.token = 'xxx',
    this.param = const {},
    this.method = Method.Get,
    this.modelType,
    this.unGetMethodQueryParam = const {}
  });

}