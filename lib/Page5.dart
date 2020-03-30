import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Page5 extends StatefulWidget {
  @override
  _Page5 createState() => new _Page5();
}

class _Page5 extends State<Page5> {

  String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const loadingTag = 'loading';
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _receiveData();
  }

  void _receiveData() {
    Future.delayed(Duration(seconds: 2)).then((e){
      _words.insertAll(_words.length - 1,
        generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
      );
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //一般scrollView
    return Scrollbar(
      child: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: str.split('')
                .map((c) => Text(c, textScaleFactor: 2.0,))
                .toList(),
          ),
        ),
      ),
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    //一般构造器的tableiew
//
//    return ListView.builder(
//        itemCount: 100,
//        itemExtent: 25,
//        itemBuilder: (BuildContext context, int index) {
//          return ListTile(title: Text('$index'));
//        }
//    );
//  }


//  @override
//  Widget build(BuildContext context) {
//
//    Widget divider1 = Divider(color: Colors.blue);
//    Widget divider2 = Divider(color: Colors.green,);
//
//  //下划线构造器
//    return ListView.separated(
//      itemBuilder: (BuildContext context, int index) {
//        return ListTile(title: Text('$index'));
//      },
//      separatorBuilder: (BuildContext context, int index) {
//        return index % 2 == 0 ? divider1 : divider2;
//      },
//      itemCount: 100,
//    );
//  }


//  @override
//  Widget build(BuildContext context) {
//    //模拟异步数据获取上拉加载的tableView
//    return ListView.separated(
//      separatorBuilder: (context, index) => Divider(height: 0,),
//      itemCount: _words.length,
//      itemBuilder: (context, index) {
//        if (_words[index] ==  loadingTag) {
//          if (_words.length - 1 < 100) {
//            _receiveData();
//            return Container(
//              padding: const EdgeInsets.all(16),
//              alignment: Alignment.center,
//              child: SizedBox(
//                width: 24,
//                height: 24,
//                child: CircularProgressIndicator(strokeWidth: 2),
//              ),
//            );
//          }else {
//            return Container(
//              padding: EdgeInsets.all(16),
//              alignment: Alignment.center,
//              child: Text('没有更多了', style: TextStyle(color: Colors.grey)),
//            );
//          }
//        }
//        return ListTile(title: Text(_words[index]));
//      },
//    );
//  }



}
















