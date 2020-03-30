import 'package:flutter/widgets.dart';

class PageTestInheritedWidgetModel extends ChangeNotifier {
   bool isEnable;
   String showedText;

   PageTestInheritedWidgetModel({this.isEnable, this.showedText}) ;

   void setDatas({bool isEnable,String showedText}){
     this.isEnable = isEnable;
     this.showedText = showedText;
     notifyListeners();
   }
}