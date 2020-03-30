import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Page1 extends StatefulWidget {
  static const String routerName = '/Page1';

  int indexedStackIndex = 0;

  int selectCount = 0;


  Page1({Key key}) : super(key: key);

  @override
  _Page1 createState() => _Page1();
}

class _Page1 extends State<Page1> {
  @override
  void initState() {
    super.initState();
    print("initstate");
  }

  @override
  Widget build(BuildContext context) {
//    final BlocServicePage8 blocService = BlocProvider.of<BlocServicePage8>(context);

    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print('1111111');
        print(notification.msg);
        return true;
      },
      child: Scaffold(
        appBar: new AppBar(
          title: Text('Page1'),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              //loose 自适应大小  expand扩张到与stack同等大小，且需要详细的长宽参数
              fit: StackFit.loose,
              overflow: Overflow.visible,
              alignment: Alignment.center,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 50,
                  color: Color(0xfff48fb1),
                ),
                Text(
                  'Stack demo',
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.green,
                  ),
                ),
                Positioned(
                  left: 50,
                  child: Stack(
//                  alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        width: 25,
                        height: 25,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IndexedStack(
              index: widget.indexedStackIndex,
              children: [
                Builder(builder: (builderContext) {
                  return IconButton(
                    icon: Icon(Icons.update),
                    onPressed: (){
                      _iconButtonSelect(builderContext);
                    },
                  );
                },),
                IconButton(
                  icon: Icon(Icons.access_alarm),
                  onPressed: (){
                    _iconButtonSelect(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: (){
                    _iconButtonSelect(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.alarm_off),
                  onPressed: (){
                    _iconButtonSelect(context);
                  },
                ),
              ],
            ),
//            RaisedButton(
//              onPressed: () {
//                blocService.updateCount.add(widget.selectCount++);
//              },
//              child: Text('Test Bloc'),
//            ),
//            StreamBuilder<int>(
//              stream: blocService.outCount,
//              initialData: 0,
//              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//                return Text('${snapshot.data}');
//              },
//            )

          ],
        ),
      ),
    );
  }

  void _iconButtonSelect(BuildContext context) {
    widget.indexedStackIndex++;
    if(widget.indexedStackIndex >= 4) {
      widget.indexedStackIndex = 0;
    }

    MyNotification('hi').dispatch(context);

    setState(() {
    });
  }

}


class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}