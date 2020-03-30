import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitialState extends LoginState {
  @override
  String toString() => 'LoginInitialState';
}

class LoginSuccessState extends LoginState {
  @override
  String toString() => 'LoginSuccessState';
}

class LoginFailureState extends LoginState {
  @override
  String toString() => 'LoginFailureState';
}

class LoginBtnEnableState extends LoginState {
  final bool isEnable;
  LoginBtnEnableState({@required this.isEnable}) : super([isEnable]);

  @override
  String toString() => 'LoginBtnEnableState {isEnable:$isEnable}';
}