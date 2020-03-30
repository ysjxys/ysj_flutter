library dart.router;

import 'package:ysj_flutter/Page2.dart';
import 'package:fluro/fluro.dart';
import 'package:ysj_flutter/Page6.dart';
import 'package:ysj_flutter/Page1.dart';


class Application {
  static Router router;

  static Future navigateReplaceRightTo(context, path) {
    return Application.router.navigateTo(context, path, transition: TransitionType.inFromRight, replace: true);
  }

}


class Routers {
  static String root = '/';
  static const String page1RouterName = Page1.routerName;
  static const String page6RouterName = Page6.routerName;

  static void configureRouters(Router router) {
    router.define(page6RouterName, handler: Handler(handlerFunc: (context, params) => Page6()));
    router.define(page1RouterName, handler: Handler(handlerFunc: (context, params) => Page1()));
  }
}