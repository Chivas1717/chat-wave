import 'package:clean_architecture_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  CheckOtpCubit({
    required this.repository,
  }) : super(CheckOtpInitial());

  final AuthRepository repository;

  void checkOtp(String phoneNumber, String code) async {
    emit(CheckOtpLoading());

    final otpCheckingResult = await repository.checkOtp(phoneNumber, code);

    otpCheckingResult.fold(
      (failure) => emit(CheckOtpFailure(
        errorMessage: failure.errorMessage,
        errorCode: failure.errorCode ?? 1,
      )),
      (result) => emit(CheckOtpSuccess(isFirstLogin: result)),
    );
  }
}
