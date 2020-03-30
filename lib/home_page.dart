import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Page2.dart';
import 'Page1.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'Page5.dart';
import 'Page6.dart';
import 'Page7.dart';
import 'Page8.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  var _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
    Page6(),
    Page7(),
    NotificationRoute(),
  ];

  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Material(
        color: Color(0xFFF0EEEF),
        child: SafeArea(
          bottom: false, 
          child: Container(
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(_selectedIndex == 0 ? 'images/home_selected.png' : 'images/home_normal.png'),
                  title: Text('一')
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(_selectedIndex == 1 ? 'images/product_selected.png' : 'images/product_normal.png'),
                  title: Text('二'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(_selectedIndex == 2 ? 'images/product_selected.png' : 'images/product_normal.png'),
                  title: Text('三')
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(_selectedIndex == 3 ? 'images/product_selected.png' : 'images/product_normal.png'),
                    title: Text('四')
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(_selectedIndex == 4 ? 'images/product_selected.png' : 'images/product_normal.png'),
                    title: Text('五')
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(_selectedIndex == 5 ? 'images/product_selected.png' : 'images/product_normal.png'),
                    title: Text('六')
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(_selectedIndex == 6 ? 'images/product_selected.png' : 'images/product_normal.png' ),
                    title: Text('七')
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(_selectedIndex == 7 ? 'images/product_selected.png' : 'images/product_normal.png' ),
                    title: Text('八')
                )
                
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemSelected,
              type: BottomNavigationBarType.fixed,
            ),
          )
        )
      ),
    );
  }
}


