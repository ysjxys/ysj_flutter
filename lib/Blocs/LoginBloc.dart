import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ysj_flutter/Events/LoginEvent.dart';
import 'package:ysj_flutter/States/LoginState.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  @override
  LoginState get initialState => LoginInitialState();

  Stream<LoginState> transform(Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent event) next) {

    final nameChangeObservable = Observable(events).where((event) => event is UserNameChangeEvent);
    final passwordChangeObservable = Observable(events).where((event) => event is PasswordChangeEvent);

    final loginButtonStatusObservable = Observable.combineLatest2(
      passwordChangeObservable,
      nameChangeObservable,
          (event1, event2) {
        return LoginBtnEnableEvent(isEnable: event1.password.isNotEmpty && event2.userName.isNotEmpty);
      },
    );

    return super.transform(
        Observable(events).mergeWith([
          loginButtonStatusObservable,
        ]),
        next);
  }

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressEvent) {
      print(event.userName);
      print(event.password);
      if (event.userName == '111' && event.password == '111') {
        yield LoginSuccessState();
      }else {
        yield LoginFailureState();
      }
    }else if (event is LoginBtnEnableEvent) {
      yield LoginBtnEnableState(isEnable: event.isEnable);
    }

  }

}