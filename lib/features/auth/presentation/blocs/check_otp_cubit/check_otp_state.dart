part of 'check_otp_cubit.dart';

@immutable
abstract class CheckOtpState {
  const CheckOtpState();
}

class CheckOtpInitial extends CheckOtpState {}

class CheckOtpFailure extends CheckOtpState {
  final String errorMessage;
  final int errorCode;

  const CheckOtpFailure({required this.errorMessage, required this.errorCode});
}

class CheckOtpSuccess extends CheckOtpState {
  final bool isFirstLogin;
  const CheckOtpSuccess({required this.isFirstLogin});
}

class CheckOtpLoading extends CheckOtpState {}
