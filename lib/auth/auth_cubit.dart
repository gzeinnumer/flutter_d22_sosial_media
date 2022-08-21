import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_credentials.dart';
import 'package:flutter_d22_sosial_media/session_cubit.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;
  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);

  void showConfirmSignUp({
    required String username,
    String? email,
    String? passowrd,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: passowrd,
    );
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials){
    return sessionCubit.showSession(credentials);
  }
}
