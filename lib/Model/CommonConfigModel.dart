import 'package:ysj_flutter/Http/HttpModel.dart';

class CommonConfigModel extends HttpModel {
  int id;
  String keyy;
  String valuee;

  @override
  CommonConfigModel({this.id, this.keyy, this.valuee}) : super();

  @override
  CommonConfigModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    keyy = json['keyy'];
    valuee = json['valuee'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyy'] = this.keyy;
    data['valuee'] = this.valuee;
    return data;
  }

}