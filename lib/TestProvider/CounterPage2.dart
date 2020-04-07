import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CounterChangeNotifier.dart';

class CounterPage2 extends StatefulWidget {
  @override
  _CounterPage2State createState() => _CounterPage2State();
}

class _CounterPage2State extends State<CounterPage2> {

  int i = 1;
  int j = 2;
  get x => i * j;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        ChangeNotifierProvider<CounterChangeNotifier>.value(
//            value: CounterChangeNotifier()),
        ChangeNotifierProvider<CounterChangeNotifier>(create: (_) => CounterChangeNotifier(),),
      ],
      child: Consumer<CounterChangeNotifier>(builder: (context, counter, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('page1'),
          ),
          body: Center(
            child: Text('${Provider.of<CounterChangeNotifier>(context).count}'),
          ),
          floatingActionButton: Builder(builder: (context) {
            print('按钮重绘。。。。。');
            return FloatingActionButton(
              onPressed: () {
                Provider.of<CounterChangeNotifier>(context, listen: false)
                    .add();
              },
              child: Icon(Icons.add),
            );
          }),

//            FloatingActionButton(
//            onPressed: () {
//              Provider.of<CounterChangeNotifier>(context, listen: false).add();
//            },
//            child: Icon(Icons.add),
//          ),
        );
      }),
    );
  }
}
