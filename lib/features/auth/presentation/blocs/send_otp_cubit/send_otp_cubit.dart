import 'package:clean_architecture_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit({
    required this.repository,
  }) : super(OtpInitial());

  final AuthRepository repository;

  void sendOtp(
    String phoneNumber,
  ) async {
    emit(OtpLoading());

    final otpCheckingResult = await repository.sendOtp(
      phoneNumber,
    );

    otpCheckingResult.fold(
      (failure) {
        print(failure.errorMessage);
        emit(OtpFailure(
          errorMessage: failure.errorMessage,
          errorCode: failure.errorCode ?? 1,
        ));
      },
      (result) => emit(OtpSuccess()),
    );
  }
}
