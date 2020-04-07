import 'dart:developer';
import 'package:flutter/cupertino.dart';

class CounterChangeNotifier with ChangeNotifier {

  int _count = 0;
  int get count => _count;

//  CounterChangeNotifier(this._count);

  void add() {
    _count++;
    notifyListeners();
  }

}


//class MyNotifier with ChangeNotifier {
//  MyNotifier() {
//    _fetchSomething();
//  }
//
//  Future<void> _fetchSomething() async {}
//}