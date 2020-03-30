import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Page2.dart';
import 'Page1.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'Page5.dart';
import 'Page6.dart';
import 'Page7.dart';
import 'PageIOS1.dart';
import 'PageIOS2.dart';

class HomePageIOS extends StatefulWidget {
  @override
  _HomePageIOS createState() => new _HomePageIOS();
}

class _HomePageIOS extends State<HomePageIOS> {

  int _selectedIndex = 0;

  var _pages = [
//    Page1(),
//    Page2(),
//    Page3(),
//    Page4(),
//    Page5(),
//    Page6(),
//    Page7(),

  ];

  var _pages2 = [
    PageIOS1(),
    PageIOS2()
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex == 0 ? 'images/product_selected.png' : 'images/product_normal.png' ),
                title: Text('88')
            ),
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex == 1 ? 'images/product_selected.png' : 'images/product_normal.png' ),
                title: Text('88')
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemSelected,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
              builder: (context){
                return CupertinoPageScaffold(
                  child: _pages2[_selectedIndex],
                );
              }
          );
        }
    );
  }

}