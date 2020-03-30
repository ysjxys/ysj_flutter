//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//class PageIOS1 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//        child: new Text("页面一",
//        style: new TextStyle(fontSize:36.0,
//        color: CupertinoColors.activeBlue,
//        fontWeight: FontWeight.w800,
//        )
//      )
//    );
//  }
//}

class PageIOS1 extends StatefulWidget {
  @override
  _PageIOS1 createState() => _PageIOS1();
}

class _PageIOS1 extends State<PageIOS1> {

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0.5, color: CupertinoColors.darkBackgroundGray),
//        previousPageTitle: '返回',
        middle: Text('我是中间文字'),
//        leading: CupertinoButton(
//          child: Image.asset('images/icon_route.png'),
//          onPressed: (){
//            print('left item select');
//          }
//        ),
        trailing: CupertinoButton(
          child: Text('我是右边'),
          onPressed: (){
            print('right item select');
          }
        ),
      ),
      child: SafeArea(
          child: Container(
            child: Center(
                child: Text("页面一1",
                    style: TextStyle(
                      fontSize:36.0,
                      color: CupertinoColors.activeBlue,
                      fontWeight: FontWeight.w800,
                    )
                )
            ),
          ),
      )
    );
  }
}
