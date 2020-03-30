import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class UserNameChangeEvent extends LoginEvent {
  final String userName;
  UserNameChangeEvent({@required this.userName});

  @override
  String toString() => 'UserNameChangeEvent {userName: $userName}';
}

class PasswordChangeEvent extends LoginEvent {
  final String password;
  PasswordChangeEvent({@required this.password});

  @override
  String toString() => 'PasswordChangeEvent {password: $password}';
}

class LoginPressEvent extends LoginEvent {
  final String userName;
  final String password;

  LoginPressEvent({
    @required this.userName,
    @required this.password,
  }) : super([
          userName,
          password,
        ]);

  @override
  String toString() => 'LoginPressEvent {userName:$userName, password:$password}';
}

class LoginBtnEnableEvent extends LoginEvent {
  final bool isEnable;

  LoginBtnEnableEvent({
    @required this.isEnable,
  }) : super([
    isEnable,
  ]);

  @override
  String toString() => 'LoginBtnEnableEvent {isEnable:$isEnable}';
}
