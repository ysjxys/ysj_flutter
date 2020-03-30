import 'package:flutter/material.dart';

class CommonModel {
  String title;
  String url;
  Image image;
  String detail;

  CommonModel({
    this.title,
    this.url,
    this.image,
    this.detail = 'default detail',
  });
}