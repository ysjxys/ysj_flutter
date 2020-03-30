import 'package:flutter/cupertino.dart';

class PageIOS2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: new Text("页面二",
            style: new TextStyle(fontSize:36.0,
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w800,
            )
        )
    );
  }
}