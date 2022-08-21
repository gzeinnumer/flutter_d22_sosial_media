import 'package:flutter_d22_sosial_media/auth/login/login_status.dart';

class LoginState {
  final String username;

  bool get isValidUsername => username.toString().length > 3;

  final String password;

  bool get isValidPassword => password.toString().length > 6;

  final LoginStatus? status;

  LoginState({
    this.username = "",
    this.password = "",
    this.status = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
