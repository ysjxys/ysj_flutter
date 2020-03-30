import 'HttpAPI.dart';
import 'HttpPath.dart';
import 'package:ysj_flutter/Model/CommonConfigModel.dart';
import 'HttpRequest.dart';
import 'HttpModel.dart';

class HttpService {

  static Future getTestData() async {
    HttpRequest request = HttpRequest(HttpPath.testURL);
    var response = await HttpAPI.request(request);

    CommonConfigModel model = CommonConfigModel.fromJson(response);
    return model;
  }

  static Future registerAccount(Map<String, dynamic> param) async {
    HttpRequest request = HttpRequest(
        HttpPath.registerURL,
        method: Method.Post,
        param: param
    );
    var response = await HttpAPI.request(request);

    HttpModel model = HttpModel.fromJson(response);
    return model;
  }
}
