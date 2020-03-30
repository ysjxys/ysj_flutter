import 'package:flutter/material.dart';
import 'CustomTextField.dart';
import 'PageTestInherited.dart';
import 'PageTestInheritedWidgetModel.dart';

class PageTestInheritedWidget extends StatefulWidget {
  @override
  _PageTestInheritedWidget createState() => new _PageTestInheritedWidget();
}

class _PageTestInheritedWidget extends State<PageTestInheritedWidget> {
//  bool isEnable = false;
//  String showedText = '';
  PageTestInheritedWidgetModel pageModel =
      PageTestInheritedWidgetModel(isEnable: false, showedText: '112233');

  Widget childWidget = Builder(builder: (context2) {
    print('childWidget setState');
    return Text('childWidget');
  });

  @override
  Widget build(BuildContext context) {
    print('root setState');
    return P(
      data: pageModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PageTestInheritedWidget'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Builder(
                builder: (BuildContext buildContext) {
                  print('CustomTextField setState');
                  return CustomTextField(
                    isEditing: PageTestInherited.of(buildContext).isEnable,
                    text: PageTestInherited.of(buildContext).showedText,
                  );
                },
              ),

              Builder(builder: (context2) {
                print('TestText setState');
                return Text('TestText');
              }),

              childWidget,

              Builder(builder: (BuildContext btnContext) {
                print('button setState');
                return FlatButton(
                    onPressed: () {
//                    setState(() {
//                      pageModel.isEnable = true;
//                      pageModel.showedText = '2234';
////                      pageModel.isEnable = !pageModel.isEnable;
//                    });

                      //这个也可以封装到静态方法of里面，然后根据一个bool参数区分dependOnInheritedWidgetOfExactType
                      PageTestInherited inherited = btnContext
                          .getElementForInheritedWidgetOfExactType<
                              PageTestInherited>()
                          .widget;
//                      print('is same = ${identical(pageModel, inherited.pageModel)}');
                      //这段更新方法应该写在pageModel内部
                      inherited.pageModel.setDatas(isEnable: true,showedText: 'hahahaha');
                    },
                    child: Text('change'));
              })
            ],
          ),
        ),
      ),
    );
  }
}
