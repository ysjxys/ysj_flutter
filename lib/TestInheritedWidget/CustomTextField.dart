import 'package:flutter/material.dart';
import 'PageTestInherited.dart';

class CustomTextField extends StatefulWidget {
  final bool isEditing;
  String text;

  CustomTextField({
    Key key,
    @required this.isEditing,
    this.text,
  }) : super(key: key);

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (textEditingController == null) {
      textEditingController = TextEditingController();
    }
    textEditingController.text = widget.text;

    print('CustomTextField setsState');

    return widget.isEditing
        ? TextField(
            controller: textEditingController,
          )
        : Text(widget.text);
  }
}
