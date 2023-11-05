part of 'send_otp_cubit.dart';

@immutable
abstract class SendOtpState {
  const SendOtpState();
}

class OtpInitial extends SendOtpState {}

class OtpFailure extends SendOtpState {
  final String errorMessage;
  final int errorCode;

  const OtpFailure({required this.errorMessage, required this.errorCode});
}

class OtpSuccess extends SendOtpState {}

class OtpLoading extends SendOtpState {}
