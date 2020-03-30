import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ysj_flutter/Units/Units.dart';

class Page4 extends StatefulWidget {
  bool _isChecked = false;
  bool _isChecked2 = false;

  String _radioValue = 'valueT1';
  String _radioListTileValue = 'radioListTileV1';
  double _sliderValue = 50;

  bool _isSwitchOn = true;
  int _animatedSwitcherText = 1;

  IconData _actionIcon = Icons.delete;

  @override
  _Page4 createState() => new _Page4();
}

class _Page4 extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Page4'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Expanded会拉伸子控件的宽度，
            Expanded(
              child: ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        //RaiseButton
                        _testRaiseButton(),

                        //RaiseButton
                        _testRaiseButton2(),

                        //OverflowBox
                        _testOverflowBox(),

                        //DecoratedBox
                        _testDecoratedBox(),

                        //RotatedBox
                        _testRotatedBox(),
                      ],
                    ),
                  ),

                  //DropdownButton
                  _testDropdownButton(),

                  //Checkbox
                  _testCheckbox(),

                  //CheckboxListTile
                  _testCheckboxListTile(),

                  //RichText
                  _testRichText(),

                  //Radio
                  _testRadio(),

                  //RadioListTile
                  _testRadioListTile(),

                  //Slider
                  _testSlider(),

                  //SliderTheme
                  _testSliderTheme(),

                  //switch
                  _testSwitch(),

                  //SwitchTile
                  _testSwitchTile(),

                  //AnimatedSwitcher
                  _testAnimatedSwitcher(),

                  //center
                  _testCenter(),

                  //ConstrainedBox
                  _testConstrainedBox(),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //旋转控件
  Widget _testRotatedBox() {
    return RotatedBox(
      quarterTurns: 2,
      child: Text('RotatedBox'),
    );
  }

//  icon: ImageIcon(AssetImage("images/icon_more.png"),),
  Widget _testDecoratedBox() {
//    return Image.asset('images/pic01.png');
    return Container(
      height: 80,
      width: 80,
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          color: Colors.purple,
          image: DecorationImage(
            image: Image.asset('images/pic02.png').image,
//            image: ExactAssetImage('images/pic01.png'),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            width: 2,
            color: Colors.blue[300],
          ),
        ),
      ),
    );
  }

  //可超过边界的widget
  Widget _testOverflowBox() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.green,
      child: OverflowBox(
        minWidth: 20,
        minHeight: 20,
        maxWidth: 40,
        maxHeight: 60,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 50,
          height: 100,
          color: Colors.purple,
//          child: Text('OverflowBox'),
        ),
      ),
    );
  }

  //无法超出父控件的ConstrainedBox
  Widget _testConstrainedBox() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
        child: Container(
          width: 120,
          height: 40,
          color: Colors.purple,
          child: Text('12345678901234567890'),
        ),
      ),
    );
  }

  Widget _testCenter() {
    return Center(
      heightFactor: 1.5, //比例系数，即Center宽高相较于子控件的宽高比
      child: Container(
        width: 100,
        height: 40,
        color: Colors.grey,
        constraints: BoxConstraints(maxWidth: 40),
        child: Text(
          'center',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _testAnimatedSwitcher() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
//      child: Text(
//        '${widget.animatedSwitcherText}',
//        style: Theme.of(context).textTheme.display4,
//        key: ValueKey<int>(widget.animatedSwitcherText),
//      ),
      child: IconButton(
        //如果 Widget 类型一样，只是数据不一样，那么想要动画，就必须添加 Key
        key: UniqueKey(),
        icon: Icon(widget._actionIcon),
        onPressed: () {
          setState(() {
            if (widget._actionIcon == Icons.delete) {
              widget._actionIcon = Icons.refresh;
            } else {
              widget._actionIcon = Icons.delete;
            }
          });
        },
      ),
      transitionBuilder: (Widget child, Animation animation) {
        return ScaleTransition(child: child, scale: animation);
      },
    );
  }

  Widget _testSwitchTile() {
    return SwitchListTile.adaptive(
      title: Text('SwitchListTile title'),
      subtitle: Text('SwitchListTile subtitle'),
      secondary: Icon(Icons.add_a_photo),
      activeColor: Colors.yellow,
      value: widget._isSwitchOn,
      onChanged: (value) {
        print(value);
        setState(() {
          widget._isSwitchOn = value;
        });
      },
    );
  }

  Widget _testSwitch() {
    //adaptive  ios风格
    return Switch.adaptive(
      value: widget._isSwitchOn,
      onChanged: (value) {
        print(value);
        setState(() {
          widget._isSwitchOn = value;
        });
      },
    );
  }

  Widget _testSliderTheme() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.green,
        //滑过的覆盖颜色/实际进度的颜色
        inactiveTrackColor: Colors.yellow,
        //进度条的底色
        thumbColor: Colors.purple,
        //滑块的颜色
        overlayColor: Colors.red,
        //滑块滑动时边缘颜色
        valueIndicatorColor: Colors.grey,
        //slider label 背景色
        valueIndicatorTextStyle:
            TextStyle(color: Colors.white), //slider label textStyle
      ),
      child: Slider(
        label: '${widget._sliderValue}',
        value: widget._sliderValue,
        min: 0.0,
        max: 100.0,
        divisions: 100,
        //进度100等分
        onChanged: (value) {
          print(value);
          setState(() {
            widget._sliderValue = value;
          });
        },
      ),
    );
  }

  Widget _testSlider() {
    return Slider.adaptive(
      min: 0.0,
      max: 100.0,
      divisions: 100,
      value: widget._sliderValue,
      onChanged: (value) {
        print(value);
        setState(() {
          widget._sliderValue = value;
        });
      },
    );
  }

  Widget _testRadioListTile() {
    return Column(
      children: <Widget>[
        RadioListTile(
          value: 'radioListTileV1',
          title: Text('我是RadioListTile title'),
          subtitle: Text('我是RadioListTile subtitle'),
          //leading / trailing / platform
          controlAffinity: ListTileControlAffinity.trailing,
          secondary: Icon(Icons.add_a_photo),
          activeColor: Colors.yellow,
          groupValue: widget._radioListTileValue,
          onChanged: (value) {
            print(value);
            setState(() {
              widget._radioListTileValue = value;
            });
          },
        ),
        RadioListTile(
          value: 'radioListTileV2',
          title: Text('我是RadioListTile title2'),
          subtitle: Text('我是RadioListTile subtitle2'),
          groupValue: widget._radioListTileValue,
          onChanged: (value) {
            print(value);
            setState(() {
              widget._radioListTileValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _testRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'valueT1',
          groupValue: widget._radioValue,
          onChanged: (value) {
            print(value);
            setState(() {
              widget._radioValue = value;
            });
          },
        ),
        Radio(
          value: 'valueT2',
          groupValue: widget._radioValue,
          onChanged: (value) {
            print(value);
            setState(() {
              widget._radioValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _testRichText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '123',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(
            text: '456',
            style: TextStyle(color: Colors.purple),
          ),
          TextSpan(
            text: '789',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _testCheckboxListTile() {
    return CheckboxListTile(
      title: Text('我是CheckboxListTile title'),
      subtitle: Text('我是CheckboxListTile subtitle'),
      dense: true,
      //文字是否对齐，图标高度
//      selected: true,//默认文字是否高亮，即activeColor
      //leading 按钮前，文字后，trailing/platform 按钮后，文字前，默认
      controlAffinity: ListTileControlAffinity.platform,
      secondary: Icon(Icons.add_a_photo),
      activeColor: Colors.yellow,
      value: widget._isChecked2,
      onChanged: (isSelect) {
        print(isSelect);
        setState(() {
          widget._isChecked2 = isSelect;
        });
      },
    );
  }

  Widget _testCheckbox() {
    return Checkbox(
      activeColor: Colors.yellow,
      value: widget._isChecked,
      onChanged: (isSelect) {
        print(isSelect);
        setState(() {
          widget._isChecked = isSelect;
        });
      },
    );
  }

  Widget _testDropdownButton() {
    return DropdownButton(
      hint: Text('我是下拉菜单标题'),
      items: [
        DropdownMenuItem(
          child: Text('123'),
          value: 'value1',
        ),
        DropdownMenuItem(
          child: Text('223'),
          value: 'value2',
        ),
      ],
      onChanged: (value) {
        print(value);
      },
    );
  }

  Widget _testRaiseButton2() {
    return Container(
      width: 150,
      height: 40,
      child: RaisedButton.icon(
        //FlatButton
        color: Colors.yellow,
        splashColor: Colors.yellow,
        //点击按钮时水波纹的颜色
        highlightColor: Colors.yellow,
        //高亮颜色，点击（长按）按钮后的颜色
//        padding: EdgeInsets.fromLTRB(206, 20, 207, 20),//error  RaisedButton.icon没有padding
        onPressed: () {
          setState(() {
            widget._animatedSwitcherText += 1;
          });
        },
        icon: Icon(
          Icons.accessible,
        ),
        label: Text('fuck off'),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _testRaiseButton() {
    return RaisedButton(
      color: Colors.red,
//      padding: EdgeInsets.fromLTRB(206, 20, 207, 20),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      onPressed: () {},
      textColor: Colors.white,
      child: Text('呃呃呃'),
    );
  }
}
