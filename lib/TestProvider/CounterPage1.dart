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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterChangeNotifier(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('page1'),),
        body: Center(
          child: Text('${Provider.of<CounterChangeNotifier>(context)}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<CounterChangeNotifier>(context).add();
//            Navigator.push(context, MaterialPageRoute(builder: (context){
//              return CounterPage2();
//            }));
          },
          child: Icon(Icons.arrow_forward_ios),
        ),
      )
    );
  }
}
