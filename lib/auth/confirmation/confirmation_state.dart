import 'package:flutter_d22_sosial_media/auth/form_submission_status.dart';

class ConfirmationState {
  final String code;
  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus status;

  ConfirmationState({
    this.code = "",
    this.status = const InitialFormStatus(),
  });

  ConfirmationState copyWith({
    String? code,
    FormSubmissionStatus? status,
  }) {
    return ConfirmationState(
      code: code ?? this.code,
      status: status ?? this.status
    );
  }
}
