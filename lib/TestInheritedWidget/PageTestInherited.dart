import 'package:flutter/material.dart';
import 'PageTestInheritedWidgetModel.dart';

class PageTestInherited extends InheritedWidget {
  final PageTestInheritedWidgetModel pageModel;

  PageTestInherited({this.pageModel, Widget child}) : super(child: child);

  static PageTestInheritedWidgetModel of(BuildContext context) {
    PageTestInherited inheritedWidget =
        context.dependOnInheritedWidgetOfExactType();
    return inheritedWidget.pageModel;
  }

  @override
  bool updateShouldNotify(PageTestInherited oldWidget) {
    bool result = (oldWidget.pageModel.isEnable != pageModel.isEnable) ||
        (oldWidget.pageModel.showedText != pageModel.showedText);
    print("${oldWidget.pageModel.isEnable},${oldWidget.pageModel.showedText}");
    print("${pageModel.isEnable},${pageModel.showedText}");
    print("same = ${identical(oldWidget, this)}");
    print('updateShouldNotify = $result');

    return true;
  }
}

//包裹了PageTestInherited的父类
class P extends StatefulWidget {
  Widget child;
  PageTestInheritedWidgetModel data;


  P({this.child, this.data});

  @override
  _PState createState() => _PState();
}

class _PState extends State<P> {
  void update() {

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.data.addListener(update);
  }

  @override
  void dispose() {
    super.dispose();
    widget.data.removeListener(update);
  }

  @override
  Widget build(BuildContext context) {
    return PageTestInherited(
      child: widget.child,
      pageModel: widget.data,
    );
  }
}
