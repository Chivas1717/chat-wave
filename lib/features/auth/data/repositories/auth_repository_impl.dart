import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/core/error/repository_request_handler.dart';
import 'package:clean_architecture_template/core/helper/type_aliases.dart';
import 'package:clean_architecture_template/features/auth/data/datasource/auth_datasource.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({
    required this.authDatasource,
  });

  @override
  FutureFailable<void> logOut() {
    return RepositoryRequestHandler<void>()(
      request: () => authDatasource.logOut(),
      defaultFailure: IncorrectEmailFailure(),
    );
  }

  @override
  FutureFailable<bool> sendOtp(String email) {
    return RepositoryRequestHandler<bool>()(
      request: () => authDatasource.sendOtp(email),
      defaultFailure: LogInFailure(),
    );
  }

  @override
  FutureFailable<bool> checkOtp(String phoneNumber, String code) {
    return RepositoryRequestHandler<bool>()(
      request: () => authDatasource.checkOtp(phoneNumber, code),
      defaultFailure: UnauthorizedFailure(),
    );
  }

  @override
  FutureFailable<User> getUser() {
    return RepositoryRequestHandler<User>()(
      request: () => authDatasource.getUser(),
      defaultFailure: ProfileFailure(),
    );
  }

  @override
  FutureFailable<User> getOtherUser(int id) {
    return RepositoryRequestHandler<User>()(
      request: () => authDatasource.getOtherUser(id),
      defaultFailure: ProfileFailure(),
    );
  }

  @override
  FutureFailable<User> updateUser({String? username, String? status}) {
    return RepositoryRequestHandler<User>()(
      request: () => authDatasource.updateUser(username, status),
      defaultFailure: ProfileFailure(),
    );
  }
}
