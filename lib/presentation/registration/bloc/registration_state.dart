part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationFieldsInfo extends RegistrationState {
  const RegistrationFieldsInfo({
    required this.avatarLink,
    this.emailError,
    this.passwordError,
    this.passwordConfirmationError,
    this.nameError,
  });

  final String avatarLink;
  final RegistrationEmailError? emailError;
  final RegistrationPasswordError? passwordError;
  final RegistrationPasswordConfirmationError? passwordConfirmationError;
  final RegistrationNameError? nameError;

  @override
  List<Object?> get props => [avatarLink, emailError, passwordError, passwordConfirmationError, nameError];
}

class RegistrationError extends RegistrationState {
  const RegistrationError(this.requestError);

  final RequestError requestError;

  @override
  List<Object?> get props => [requestError];
}

class RegistrationInProgress extends RegistrationState {
  const RegistrationInProgress();

  @override
  List<Object?> get props => [];
}

class RegistrationCompleted extends RegistrationState {
  const RegistrationCompleted();

  @override
  List<Object?> get props => [];
}
