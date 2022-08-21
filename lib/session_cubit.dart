import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_credentials.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';
import 'package:flutter_d22_sosial_media/session_state.dart';

class SessionCubit extends Cubit<SessionState>{
  final AuthRepository authRepo;
  SessionCubit({required this.authRepo}) : super(UnknownSessionState());

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      // final user = dataRepo.getUser(userId);
      final user = userId;
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials){
    //final user = dataDepo.getUser(credentials.userId)
    final user = credentials.username;
    emit(Authenticated(user: user));
  }

  void signOut(){
    authRepo.signOut();
    emit(Unauthenticated());
  }
}