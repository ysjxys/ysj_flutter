import 'package:flutter/material.dart';
import 'dart:ui' as ui;

///默认设计稿尺寸
double _designW = 375.0;
double _designH = 667.0;

///-------------快捷静态方法。-----------------
double pt(double size) {
//  MediaQueryData mediaQuery = MediaQuery.of(context);
  MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
  double _screenWidth = mediaQuery.size.width;
  return _screenWidth == 0.0 ? size : (size * _screenWidth / _designW);
}