import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {

  @override
  _Page3 createState() => new _Page3();
}

class _Page3 extends State<Page3> {

  Widget redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red)
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Page3'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(//column  继承自flex，垂直方向布局
          children: <Widget>[
            Row(//row  继承自flex，水平方向布局
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Fuck'),
                Text('Flutter')
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Fuck', style: TextStyle(fontSize: 22),),
                Text('Flutter')
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Text('flex Fuck', style: TextStyle(fontSize: 22),),
                Text('Flutter')
              ],
            ),
            Flex(
              direction: Axis.horizontal,
//              mainAxisAlignment: MainAxisAlignment.center, //useless
//              crossAxisAlignment: CrossAxisAlignment.center,  //useless
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                    child: Text(
                        'fuck flutter',
                        style: TextStyle(
                            fontSize: 18,
                            backgroundColor: Colors.grey
                        ),
                        textAlign: TextAlign.center,

                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 35,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 10,// 主轴(水平)方向间距
              runSpacing: 20,// 纵轴（垂直）方向间距
              alignment: WrapAlignment.center,//沿主轴方向居中
              children: <Widget>[
                Chip(label: Text('fuck'), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('a'),)),
                Chip(label: Text('fuck'), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('b'),)),
                Chip(label: Text('fuck'), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('c'),)),
                Chip(label: Text('fuck'), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('d'),)),
                Chip(label: Text('fuck'), avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('e'),)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 15, 20),
              child: Text('fuck flutter'),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50,//最小高度为50像素,影响所有的子widget
              ),
              child: Container(
                height: 5,
                child: redBox,
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: redBox,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.green]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0
                  )
                ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text('fk flutter', style: TextStyle(color: Colors.white),),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child:Transform.translate(//Transform.scale、Transform.rotate、
                offset: Offset(-20, -5),
                child: Text('fuck flutter'),
              )
            ),
            Container(//margin的补白是在容器外部
              margin: EdgeInsets.all(20),
              color: Colors.orange,
              child: Text('hello'),
            ),
            Container(//padding的补白是在容器内部
              padding: EdgeInsets.all(20),
              color: Colors.orange,
              child: Text('world'),
            ),

          ],
        ),
      ),
    );
  }
}
