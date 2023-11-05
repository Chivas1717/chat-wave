import 'package:clean_architecture_template/core/helper/shared_preferences.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.repository,
    required this.sharedPrefsRepository,
  }) : super(UserInitial());

  final AuthRepository repository;
  final SharedPreferencesRepository sharedPrefsRepository;

  void getUser() async {
    emit(UserLoading(user: state.user));
    final userCheckingResult = await repository.getUser();

    userCheckingResult.fold(
      (failure) => emit(UserUnregistered()),
      (result) => emit(UserData(user: result)),
    );
  }

  void updateUser(String? username, String? status) async {
    emit(UserLoading(user: state.user));
    final userCheckingResult =
        await repository.updateUser(username: username, status: status);

    userCheckingResult.fold(
      (failure) => emit(UserFailure(
        errorMessage: failure.errorMessage,
        errorCode: failure.errorCode ?? 1,
        user: User(),
      )),
      (result) => emit(UserData(user: result)),
    );
  }

  void logOut() async {
    final userCheckingResult = await repository.logOut();

    userCheckingResult.fold(
      (failure) => emit(UserFailure(
        errorMessage: failure.errorMessage,
        errorCode: failure.errorCode ?? 1,
        user: User(),
      )),
      (result) => emit(UserInitial()),
    );
  }

  // Future<bool> updateUser(UpdatedUserInfo updatedInfo) async {
  //   bool isSuccess = true;
  //   emit(UserLoading(user: state.user));
  //   final data = {};
  //   if (updatedInfo.name != null) {
  //     data['name'] = updatedInfo.name;
  //   }
  //   if (updatedInfo.surname != null) {
  //     data['surname'] = updatedInfo.surname;
  //   }
  //   if (updatedInfo.password != null) {
  //     data['password'] = updatedInfo.password;
  //     data['password_confirmation'] = updatedInfo.passwordConfirmation;
  //   }
  //   final userUpdateResult = await repository.updateUser(data);
  //
  //   userUpdateResult.fold(
  //     (failure) {
  //       isSuccess = false;
  //       emit(
  //         UserFailure(
  //           user: state.user,
  //           message: failure.errorMessage,
  //         ),
  //       );
  //     },
  //     (result) => emit(UserData(user: result)),
  //   );
  //   return isSuccess;
  // }
}
