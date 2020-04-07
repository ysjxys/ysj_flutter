import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CounterChangeNotifier.dart';
import 'CounterPage2.dart';

class CounterPage1 extends StatefulWidget {
  @override
  _CounterPage1State createState() => _CounterPage1State();
}

class _CounterPage1State extends State<CounterPage1> {
  @override
  Widget build(BuildContext context) {
    print('页面重绘了。。。。。。。。。。。');
    return MultiProvider(
      providers: [
//        ChangeNotifierProvider<CounterChangeNotifier>.value(value: CounterChangeNotifier()),
        ChangeNotifierProvider<CounterChangeNotifier>(create: (_) => CounterChangeNotifier(),),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('page1'),
        ),
        body: Center(
          child: Consumer<CounterChangeNotifier>(
            builder: (context, counter, _) {
              return Text('${counter.count}');
//            return Text('${Provider.of<CounterChangeNotifier>(context).count}');
            },
          ),
        ),

        floatingActionButton: Consumer<CounterChangeNotifier>(
          builder: (context, counter, _) {
            return FloatingActionButton(
              onPressed: () {
//                counter.add();
//                Provider.of<CounterChangeNotifier>(context, listen: false).add();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounterPage2();
                }));
              },
              child: Icon(Icons.arrow_forward_ios),
            );
          },
        ),

//        FloatingActionButton(
//          onPressed: () {
//            Provider.of<CounterChangeNotifier>(context, listen: false).add();
////            Navigator.push(context, MaterialPageRoute(builder: (context){
////              return CounterPage2();
////            }));
//          },
//          child: Icon(Icons.arrow_forward_ios),
//        ),
      ),

//      child: Consumer<CounterChangeNotifier>(builder: (context, counter, _) {
//        return Scaffold(
//          appBar: AppBar(
//            title: Text('page1'),
//          ),
//          body: Center(
//            child: Container(child: Text('${Provider.of<CounterChangeNotifier>(context).count}')),
//          ),
//          floatingActionButton: FloatingActionButton(
//            onPressed: () {
//              Provider.of<CounterChangeNotifier>(context, listen: false).add();
////            Navigator.push(context, MaterialPageRoute(builder: (context){
////              return CounterPage2();
////            }));
//            },
//            child: Icon(Icons.arrow_forward_ios),
//          ),
//        );
//      }),
    );
  }
}
