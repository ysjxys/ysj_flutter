import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Http/HttpAPI.dart';
import 'Http/HttpPath.dart';
import 'package:ysj_flutter/Model/CommonConfigModel.dart';
import 'package:ysj_flutter/Http/HttpService.dart';
import 'package:ysj_flutter/Http/HttpModel.dart';
import 'package:dio/dio.dart';

class Page2 extends StatefulWidget {


  TextEditingController _textController = TextEditingController()
    ..text = 'fuck flutter';

  Page2({Key key}) : super(key: key) {
    //设置默认选中文字
    _textController.selection =
        TextSelection(baseOffset: 2, extentOffset: _textController.text.length);
    _textController.addListener(() {
      print('_textController: ' + _textController.text);
    });
  }

  @override
  _Page2 createState() => new _Page2();
}

class _Page2 extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _formKey = new GlobalKey<FormState>();
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _pwdController = new TextEditingController();

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Page2'),
//        leading: GestureDetector(
//          child: Text('返回'),
//          onTap: (){
//            Navigator.pop(context, '111');
//          },
//        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.access_time),
//            child: Text('啊啊啊'),//child与icon不能同时设置
            initialValue: 'value2',
            //初始高亮单元的值
            tooltip: 'what',
            elevation: 8,
            //Z轴阴影面积
            offset: Offset(250, 250),
            //当值大于100的时候就会显示在AppBar的下面，Offset(100, 100)
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            //default 8
            onSelected: _showMenuSelection,
            onCanceled: () {
              print('onCanceled');
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuDivider(),
                PopupMenuItem(
                  enabled: false,
                  child: Text('111'),
                  value: 'value1',
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.print),
                    title: Text('shit'),
                  ),
                  value: 'value2',
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'labelText',
                    hintText: 'hintText',
                    icon: Icon(Icons.person)),
                style: TextStyle(fontSize: 18, color: Colors.purple),
                // 校验用户名
                validator: (v) {
                  return v
                      .trim()
                      .length > 0 ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: 'labelText',
                    hintText: 'hintText',
                    icon: Icon(Icons.lock)),
                validator: (v) {
                  return v
                      .trim()
                      .length > 5 ? null : '密码需不小于6位';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(5),
                        child: Text('登录'),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
//                          Form.of(context); error not this content
                          if ((_formKey.currentState as FormState)
                              .validate()) {
                            print('validate success');
                          }

                          _btnSelect();
                        },),
                    )
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  print('select');
                  _select();
                },
                child: Container(
                  color: Colors.purple,
                  child: Icon(Icons.scanner),
                  padding: EdgeInsets.all(30),
                ),
              ),

              TextField(
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'labelText',
                    prefixIcon: Icon(Icons.person),
                    hintText: 'hintText',
                    hasFloatingPlaceholder: true,
//                fillColor: Colors.grey,
//                focusColor:Colors.green,
//                hoverColor: Colors.yellow,
                    border: UnderlineInputBorder(

                    )
                ),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                ),
                cursorColor: Colors.purple,
                onChanged: (value) {
                  print('onChanged: ' + value);
                },
                controller: widget._textController,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showMenuSelection(String value) {
    //dynamic value  该处参数决定T是什么类型
    if (value == 'value1') {
      print('is value1');
    } else {
      print('else');
    }
  }

  void _select() async {
    const channel = const MethodChannel('MethodChannleScan');

    try {
      final String result = await channel.invokeMethod('flutter_scan');
      print('result:$result');
    } catch (e) {
      print(e);
    }
  }

  void _btnSelect() async {
//    CommonConfigModel model = await HttpService.getTestData();
//    print(model);

    Map<String, dynamic> param = {
      'password': '96e79218965eb72c92a549dd5a330112',
      'username': '15067199246',
      'verifyCode': '222222'
    };

    try {
      HttpModel model2 = await HttpService.registerAccount(param);
      print(model2);
    } on DioError catch (error) {
      String errStr;
      if (error is DioError && error.response?.data is Map) {
        errStr = (error.response.data as Map)["message"];
      }
      print('error:' + errStr);
    }
  }
}
