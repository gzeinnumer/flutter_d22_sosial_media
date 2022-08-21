import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_credentials.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_event.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_state.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  LoginBloc({
    required this.authRepository,
    required this.authCubit,
  }) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChangedEvent) {
      yield state.copyWith(username: event.username);
    }
    if (event is LoginPasswordChangedEvent) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmittedEvent) {
      yield state.copyWith(status: FormSubmitting());

      try {
        final userId = await authRepository.login(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(status: SubmittionSuccess());

        authCubit.launchSession(AuthCredentials(
          username: state.username,
          userId: userId,
        ));
      } on Exception catch (e) {
        // throw e;
        yield state.copyWith(status: SubmissionFailed(e));
      }
    }
  }
}
