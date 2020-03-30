import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Page7 extends StatefulWidget {
  @override
  _Page7 createState() => _Page7();
}

class _Page7 extends State<Page7> {
  final SlidableController _slidableController = SlidableController();

  List<String> _dataList = [];
  bool _isLoading = false;
  bool _isLoadAllData = false;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _mockInitData();

  }

  Future _mockInitData() async {
    setState(() {
      _isLoading = true;
    });

    Timer(Duration(milliseconds: 2000), () {
      List<String> tempList = [];
      for (int i = 0; i < 15; i++) {
        tempList.add('我是标题$i');
      }

      setState(() {
        _dataList = tempList;
        //手动取消刷新的动画
        _refreshController.refreshCompleted();
        if (_dataList.length < 15) {
          _isLoadAllData = true;
        } else {
          _isLoadAllData = false;
        }
        _isLoading = false;
      });
    });
  }

  Future _mockMoreData() async {
    setState(() {
      _isLoading = true;
    });

    int startIndex = _dataList.length;
    Timer(Duration(milliseconds: 2000), () {
      for (int i = startIndex; i < startIndex + 5; i++) {
        _dataList.add('我是标题$i');
      }
      setState(() {
        //手动取消加载更多的动画
        _refreshController.loadComplete();
        if (_dataList.length > 24) {
          _isLoadAllData = true;
          showToast('load all data');
        }
        _isLoading = false;
      });
    });
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,  // 消息框弹出的位置
        timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Page7'),
//      ),
//      body: Container(
//        child: RefreshIndicator(
//          onRefresh: _mockInitData,
//          color: Colors.yellow,
//          backgroundColor: Colors.blue,
//          child: ListView.builder(
//            itemCount: _dataList.length,
//            itemBuilder: (context, index) {
//              return _buildItem2(index);
//            },
//          ),
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page7'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: _isLoadAllData ? false : true,
          header: ClassicHeader(
            releaseText: '',
            refreshingText: '',
            completeText: '',
            idleText: '',
          ),
          footer: ClassicFooter(
            idleIcon: null,
            canLoadingIcon: null,
            canLoadingText: '上拉加载更多',
            idleText: '上拉加载更多',
            loadingIcon: null,
            loadingText: '加载中',
          ),
          onLoading: _mockMoreData,
          onRefresh: _mockInitData,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _buildItem2(index);
            },
            itemCount: _dataList.length,
          ),
        ),
      ),
    );
  }

  Widget _buildColumnBody() {
    return Column(children: <Widget>[
      Container(
        height: 50,
        child: Text('top'),
      ),
      Expanded(
          child: SafeArea(
              child: GestureDetector(
        onTap: () {
          print('SafeArea onTap');
          if (_slidableController.activeState != null) {
            _slidableController.activeState.close();
          }
        },
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _dataList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < 3) {
              return _buildItem();
            } else {
              return _buildSystemSlidableCell();
            }
//                  return _buildItem2(index);
          },
        ),
      )))
    ]);
  }

  Widget _buildSystemSlidableCell() {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      child: ListTile(title: Text('我是标题')),
      //点击确定/取消后的动画持续时间
      movementDuration: Duration(milliseconds: 30000),
      direction: DismissDirection.horizontal,
      //拖动偏移量达到阀值才会视为移除   例如0.5 偏移50%后可视为移除
      dismissThresholds: {
        DismissDirection.endToStart: 0.5,
        DismissDirection.startToEnd: 0.5
      },
      //子部件被移除时调用
      onDismissed: (direction) {
        print('onDismissed');
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text("onDismissed")));
      },
      //滑动时组件下一层显示的内容，
      // 没有设置secondaryBackground时，从右往左或者从左往右滑动都显示该内容，
      // 设置了secondaryBackground后，从左往右滑动显示该内容，从右往左滑动显示secondaryBackground的内容
      background: Container(
        color: Colors.green,
      ),
      //secondaryBackground不能单独设置，只能在已经设置了background后才能设置，从右往左滑
      secondaryBackground: Container(
          color: Colors.red,
          child: Center(
            child: Text(
              "删除",
              style: TextStyle(color: Colors.white),
            ),
          )),
      //使程序可以控制滑动后是否隐藏部件
      confirmDismiss: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          print('startToEnd');
        } else if (direction == DismissDirection.endToStart) {
          print('endToStart');
        }

        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text('标题'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('内容 1'),
                    new Text('内容 2'),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                new FlatButton(
                  child: new Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCell() {
    return GestureDetector(
      child: Container(
        height: 80,
        child: Text('cell'),
      ),
      onTap: () {
        print('cell onTap');
        if (_slidableController.activeState != null) {
          _slidableController.activeState.close();
        }
      },
    );
  }

  Widget _buildItem2(int index) {
    return ListTile(
      leading: Text(
        _dataList[index],
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        print('index $index cell selected');
//        仍在上拉加载下拉刷新中时，若有些操作需要阻断 则
        if (_refreshController.headerStatus != RefreshStatus.idle ||
            _refreshController.footerStatus != LoadStatus.idle) {
          print('on refreshing! cell action is stoped');
          return;
        }
        print('index $index cell action go on');
      },
    );
  }

  //侧滑栏
  Widget _buildItem() {
    return Slidable(
      key: Key(UniqueKey().toString()),
      controller: _slidableController,
      // 侧滑菜单出现方式 SlidableScrollActionPane
      // SlidableDrawerActionPane SlidableStrechActionPane
      actionPane: SlidableBehindActionPane(),
      // 每个侧滑按钮所占页面的宽度比例
      actionExtentRatio: 0.15,
      //滑动比例达到多少后会自动展开
      showAllActionsThreshold: 0.5,
      //滑动比例达到展开条件后，自动展开的花费时间
      movementDuration: Duration(milliseconds: 200),
      closeOnScroll: true,
      enabled: true,
      child: _buildCell(),
      //从左往右滑动菜单
      actions: <Widget>[],
      //从右往左滑动菜单
      secondaryActions: <Widget>[
        //侧滑分享按钮
        IconSlideAction(
          color: Color(0xFFFB9758),
          iconWidget: Text(
            '分享',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          onTap: () {
            print('分享设备');
//            showModalBottomSheet(
//              context: context,
//              builder: (context) => WechatShareSheet(
//                onlySession: true,
//                webUrl: item?.shareUrl,
//                title: item?.productName,
//                description: item?.note,
//                warning: true,
//                shareOnTap: (){
//                  _requestUploadShareUrl(item);
//                },
//              ),
//            );
          },
        ),
        //侧滑删除按钮
        IconSlideAction(
          color: Color(0xFFFB5858),
          iconWidget: Text(
            '删除',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          onTap: () {
            print('删除设备');
//            showDialog(
//                context: context,
//                barrierDismissible: false,
//                builder: (BuildContext context) {
//                  return CustomIOSDialog(
//                    title: '温馨提示',
//                    content: '确认删除该设备吗?',
//                    ensureCallback: () {
//                      _requestDeleteDevice(item);
//                    },
//                  );
//                });
          },
        ),
      ],
    );
  }
}
