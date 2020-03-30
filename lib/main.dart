import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:ysj_flutter/Bloc/BlocProvider.dart';
import 'home_page.dart';
import 'home_page_ios.dart';
import 'Units/routers.dart';
import 'package:fluro/fluro.dart';
//import 'Service/BlocServicePage8.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    //Android
    return MaterialApp(
//      home: BlocProvider<BlocServicePage8>(
//        bloc: BlocServicePage8(),
//        child: HomePage(),
//      ),
      home: HomePage(),
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
        minWidth: 0,
        height: 0,
      )),
    );

    //iOS
    return CupertinoApp(
      title: 'iOS风格测试',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.darkBackgroundGray,
      ),
      home: HomePageIOS(),
    );
  }
}
