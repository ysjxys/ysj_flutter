import 'package:flutter/material.dart';

//import 'Service/BlocServicePage8.dart';
//import 'package:ysj_flutter/Bloc/BlocProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ysj_flutter/Events/LoginEvent.dart';
import 'package:ysj_flutter/States/LoginState.dart';
import 'Blocs/LoginBloc.dart';

class NotificationRoute extends StatefulWidget {
  int selectCount = 0;

  @override
  NotificationRouteState createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String msg = "";
  String blocCallBackHandle = '';

  LoginBloc loginBloc;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
    userNameController.addListener(() => loginBloc
        .dispatch(UserNameChangeEvent(userName: userNameController.text)));
    passwordController.addListener(() => loginBloc
        .dispatch(PasswordChangeEvent(password: passwordController.text)));
  }

  @override
  void dispose() {
    loginBloc.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final BlocServicePage8 blocService = BlocProvider.of<BlocServicePage8>(context);

    return BlocProvider<LoginBloc>(
      bloc: loginBloc,
      child: BlocListener<LoginEvent, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
//          if (state is LoginInitialState) {
//            loginBloc.dispatch(LoginBtnEnableEvent(
//                isEnable: userNameController.text.isNotEmpty &&
//                    passwordController.text.isNotEmpty));
//          } else

            if (state is LoginSuccessState) {
            msg = 'success';
          } else if (state is LoginFailureState) {
            msg = 'failure';
          }
        },
        child: BlocBuilder(
          bloc: loginBloc,
          builder: (context, state) {
            return Center(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: userNameController,
                  ),
                  TextField(
                    controller: passwordController,
                  ),
                  FlatButton(
                    onPressed:

//                        () {
//                      loginBloc.dispatch(LoginPressEvent(
//                          userName: userNameController.text,
//                          password: passwordController.text));
//                    },

//                    (state is LoginBtnEnableState && state.isEnable)

                      (userNameController.text.isNotEmpty && passwordController.text.isNotEmpty)
                        ? () {
                            loginBloc.dispatch(LoginPressEvent(
                                userName: userNameController.text,
                                password: passwordController.text));
                          }
                        : null,
                    child: Text('登录'),
                  ),
                  Text(msg),
                ],
              ),
            );
          },
        ),
      ),
    );

//    return BlocProvider<BlocServicePage8>(
//      bloc: BlocServicePage8(),
//      child: Center(
//        child: Column(
//          children: <Widget>[
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
//          ],
//        ),
//      ),
//    );

//    //监听通知
//    return NotificationListener<MyNotification>(
//      onNotification: (notification) {
//        setState(() {
//          _msg += notification.msg + "  ";
//        });
//        return true;
//      },
//      child: Center(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
////          RaisedButton(
////           onPressed: () => MyNotification("Hi").dispatch(context),
////           child: Text("Send Notification"),
////          ),
//            Builder(
//              builder: (context) {
//                return RaisedButton(
//                  //按钮点击时分发通知
//                  onPressed: () => MyNotification("Hi").dispatch(context),
//                  child: Text("Send Notification"),
//                );
//              },
//            ),
//            Text(_msg),
//            RaisedButton(
//              onPressed: () {
//                //Adds a data [event] to the sink
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
//          ],
//        ),
//      ),
//    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
