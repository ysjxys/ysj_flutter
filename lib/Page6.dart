import 'package:flutter/material.dart';
import 'package:ysj_flutter/TestInheritedWidget/PageTestInheritedWidget.dart';
import 'package:ysj_flutter/Units/Units.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ysj_flutter/Units/common_model.dart';
import 'Page2.dart';
import 'package:ysj_flutter/Units/routers.dart';
import 'TestInheritedWidget/PageTestInheritedWidget.dart';
import 'TestProvider/CounterPage1.dart';

class Page6 extends StatefulWidget {
  static const String routerName = '/page6';

  @override
  _Page6 createState() => new _Page6();
}

class _Page6 extends State<Page6> {
  bool _isHaveNewTrain = false;

  List<CommonModel> _imagePageList = [
    CommonModel(title: '我是标题1', image: Image.asset('images/banner_bg1.png')),
    CommonModel(
        title: '我是标题2',
        image: Image.asset('images/b365haibao.png'),
        url: 'www.baidu.com')
  ];

  List<CommonModel> _toolList = [
    CommonModel(
        title: '我的方案',
        image: Image.asset('images/icon_plan.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '智慧学院',
        image: Image.asset('images/icon_knowledge.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '智能客服',
        image: Image.asset('images/icon_service.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: 'PoE计算器',
        image: Image.asset('images/icon_Calculator.png'),
        url: 'www.baidu.com'),
  ];

  List<CommonModel> _miniList = [
    CommonModel(
        title: '通用场景',
        image: Image.asset('images/pic01.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '酒店',
        image: Image.asset('images/pic02.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '办公场所',
        image: Image.asset('images/pic03.png'),
        url: 'www.baidu.com'),
  ];

  List<CommonModel> _intList = [
    CommonModel(
        title: '大平层',
        image: Image.asset('images/pic04.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '跃层',
        image: Image.asset('images/pic05.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '别墅',
        image: Image.asset('images/pic06.png'),
        url: 'www.baidu.com'),
  ];

  List<CommonModel> _knowledgeList = [
    CommonModel(
        title: 'mini系列',
        image: Image.asset('images/icon_mini.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: '智慧家居',
        image: Image.asset('images/icon_home.png'),
        url: 'www.baidu.com'),
    CommonModel(
        title: 'GR系列',
        image: Image.asset('images/icon_route.png'),
        url: 'www.baidu.com'),
  ];

  @override
  Widget build(BuildContext context) {
    _isHaveNewTrain = DateTime.now().second % 2 == 0;
//    _isHaveNewTrain = true;

    print(MediaQuery.of(context).size.height);
    Key(UniqueKey().toString());

    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: pt(238),
          child: Container(
            padding: EdgeInsets.fromLTRB(pt(5), pt(10), pt(15), pt(20)),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/pho_bg_blue.png'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: pt(20),
          top: 20,
          height: pt(44),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('images/icon_sm.png'),
                  onPressed: () {
                    print('sm select');
                  },
                ),
                IconButton(
//                  padding: EdgeInsets.fromLTRB(0, 0, pt(20), 0),
                  icon: Image.asset('images/icon_store.png'),
                  onPressed: () {
                    print('store select');
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: pt(64),
          bottom: 0,
          child: _buildBodyWidget(context),
        )
      ],
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0, pt(20), 0, 0),
      children: <Widget>[
        _buildAdWidget(context),
        Column(
          children: <Widget>[
            _buildToolWidget(),
            _buildSubTitleWidget(context, '出方案'),
            _buildPlanTitleWidget('Mini系列1'),
            _buildPlanListWidget(_miniList),
            _buildPlanTitleWidget('智慧家居系列'),
            _buildPlanListWidget(_intList),
            _buildTrainPageWidget(),
            _buildSubTitleWidget(context, '资料库'),
            _buildKnowledgeListWidget()
          ],
        ),
      ],
    );
  }

//  Widget _buildBodyWidget(BuildContext context) {
//    return Container (
//      padding: EdgeInsets.all(0),
//      color: Colors.yellow,
//      child: ListView(
//        padding: EdgeInsets.fromLTRB(0, pt(20), 0, 0),
//        children: <Widget>[
//          _buildAdWidget(context),
//          _buildToolWidget(),
//          _buildSubTitleWidget('出方案'),
//        ],
//      ),
//    );
//  }

  //底部知识库
  Widget _buildKnowledgeListWidget() {
    return Container(
      child: Column(
        children: List.generate(_knowledgeList.length, (index) {
          return _buildKnowledgeCellWidget(_knowledgeList[index]);
        }),
      ),
    );
  }

  Widget _buildKnowledgeCellWidget(CommonModel model) {
    return GestureDetector(
      onTap: () {
        print(model.url);
      },
      child: Container(
        color: Colors.white,
        height: pt(55),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: pt(17)),
              constraints: BoxConstraints.tightFor(height: pt(30)),
              alignment: Alignment.center,
              child: model.image,
            ),
            Expanded(
              child: ListTile(
                title: Text(model.title,
                    style: TextStyle(
                        fontSize: pt(16),
                        color: Color(0xFF3E3E3E),
                        fontWeight: FontWeight.normal)),
//                trailing: Icon(Icons.keyboard_arrow_right),
                trailing: RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  highlightElevation: 0,
                  constraints:
                      BoxConstraints.tightFor(width: pt(43), height: pt(20)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(pt(10))),
                  fillColor: Color(0xFF7594FF),
                  highlightColor: Color(0xFF7594FF),
                  child: Text(
                    '查看',
                    style: TextStyle(fontSize: pt(10), color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //培训海报页
  Widget _buildTrainPageWidget() {
    return _isHaveNewTrain
        ? Container(
            color: Colors.white,
//      height: pt(162),
//      width: pt(355),
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(pt(10), pt(20), pt(10), pt(20)),
            child: Image.asset('images/banner_bg1.png'),
          )
        : Container();
  }

  //创建出方案列表页
  Widget _buildPlanListWidget(List<CommonModel> list) {
    List<Widget> resultList = List<Widget>();
    for (CommonModel model in list) {
      resultList.add(Expanded(flex: 1, child: _buildSinglePlanWidget(model)));
    }

    return Container(
      color: Colors.white,
      child: Row(
        children: resultList,
      ),
    );
  }

  //创建出方案单个选项
  Widget _buildSinglePlanWidget(CommonModel model) {
    return GestureDetector(
      onTap: () {
        print(model.url);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
//            padding: EdgeInsets.fromLTRB(0, 0, 0, pt(10)),
            height: pt(90),
            width: pt(100),
            child: model.image,
            color: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(pt(16), pt(3), 0, pt(10)),
            color: Colors.white,
            child: Text(
              model.title,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: pt(10),
                  color: Color(0xFF2A2A2A)),
            ),
          )
        ],
      ),
    );
  }

  //创建出方案副标题
  Widget _buildPlanTitleWidget(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: pt(16)),
      height: pt(9.0 + 12.0 + 9.0),
      color: Colors.white,
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF696969),
          fontSize: pt(12),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  //创建副标题栏
  Widget _buildSubTitleWidget(BuildContext context, String title) {
    return Container(
      height: pt(52),
      padding: EdgeInsets.fromLTRB(pt(16), 0, pt(0), 0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 17,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF3E3E3E),
                  fontSize: pt(20),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  print(title + 'select');
                  Application.navigateReplaceRightTo(
                      context, '${Routers.page1RouterName}');
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return Page1();
//                }));
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      '全部1',
                      style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: pt(10),
                          fontWeight: FontWeight.normal),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: pt(2)),
                      child:
                          Image.asset('images/icon_right__detail_copy_4.png'),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  //创建工具栏
  Widget _buildToolWidget() {
    return Container(
      height: pt(100),
      padding: EdgeInsets.fromLTRB(pt(12), pt(0), pt(12), pt(10)),
      color: Colors.white,
      child: Row(
        children: _buildToolCellWidgetList(),
      ),
    );
  }

  //创建工具图标list
  List<Widget> _buildToolCellWidgetList() {
    List<Widget> resultList = List<Widget>();
    for (CommonModel model in _toolList) {
      resultList.add(Expanded(flex: 1, child: _buildToolCellWidget(model)));
    }
    return resultList;
  }

  //创建单个工具图标
  Widget _buildToolCellWidget(CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        print(commonModel.url);
//        Navigator.of(context).push(
//            MaterialPageRoute(builder: (context) => PageTestInheritedWidget()));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CounterPage1()));
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: commonModel.image,
              width: pt(40),
              height: pt(40),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: pt(6)),
              child: Text(
                commonModel.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF3E3E3E),
                  fontSize: pt(10),
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //轮播广告
  Widget _buildAdWidget(BuildContext context) {
    return Container(
      height: pt(176),
      padding: EdgeInsets.fromLTRB(pt(12), 0, pt(12), 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(pt(6))),
      child: Swiper(
        itemCount: _imagePageList.length,
        autoplay: true,
        autoplayDelay: 1500,
        pagination: SwiperPagination(alignment: Alignment.bottomRight),
        itemBuilder: (BuildContext context, int index) {
          return _imagePageList[index].image;
        },
        onTap: (index) {
          print(_imagePageList[index].title);
        },
      ),
    );
  }
}
