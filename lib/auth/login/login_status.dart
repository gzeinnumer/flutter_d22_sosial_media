abstract class LoginStatus{
  const LoginStatus();
}

class InitialFormStatus extends LoginStatus{
  const InitialFormStatus();
}

class FormSubmitting extends LoginStatus{}

class SubmittionSuccess extends LoginStatus{}

class SubmissionFailed extends LoginStatus{
  final Exception exception;

  SubmissionFailed(this.exception);
}