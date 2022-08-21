import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_event.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_state.dart';
import 'package:flutter_d22_sosial_media/auth/form_submission_status.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChangedEvent) {
      yield state.copyWith(code: event.code);

      // Form submitted
    } else if (event is ConfirmationSubmittedEvent) {
      yield state.copyWith(status: FormSubmitting());

      try {
        final userId = await authRepo.confirmSignUp(
          username: authCubit.credentials.username,
          requiredconfiramtionCode: state.code,
        );
        yield state.copyWith(status: SubmissionSuccess());

        final credentials = authCubit.credentials;
        credentials.userId = userId;

        authCubit.launchSession(credentials);
      } on Exception catch (e) {
        yield state.copyWith(status: SubmissionFailed(e));
      }
    }
  }
}
