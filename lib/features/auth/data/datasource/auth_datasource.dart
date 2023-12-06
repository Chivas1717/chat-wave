import 'package:clean_architecture_template/core/helper/shared_preferences.dart';
import 'package:clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<bool> sendOtp(String phoneNumber);

  Future<bool> checkOtp(String phoneNumber, String code);

  Future<bool> logOut();

  Future<User> getOtherUser(int id);

  Future<User> getUser();

  Future<User> updateUser(String? username, String? status);
}

class AuthDatasourceImpl extends AuthDatasource {
  AuthDatasourceImpl({
    required this.dio,
    required this.sharedPreferencesRepository,
  });

  final Dio dio;
  final SharedPreferencesRepository sharedPreferencesRepository;

  @override
  Future<bool> logOut() async {
    final result = await dio.post(
      '/api/auth/logout/',
    );
    await sl<SharedPreferencesRepository>()
        .removeString(key: SharedPreferencesKeys.token);

    return result.statusCode == 200 || result.statusCode == 201;
  }

  @override
  Future<bool> sendOtp(String phoneNumber) async {
    final result = await dio.post(
      '/api/auth/generate_otp/',
      data: {
        'phone_number': phoneNumber,
      },
    );
    final bool isCodeSent =
        result.statusCode == 200 || result.statusCode == 201;

    return isCodeSent;
  }

  @override
  Future<bool> checkOtp(String phoneNumber, String code) async {
    final result = await dio.post(
      '/api/auth/login/',
      data: {
        'phone_number': phoneNumber,
        'otp': code,
      },
    );

    if (result.data['token'] != null) {
      final String token = result.data['token'];

      await sharedPreferencesRepository.writeString(
        key: SharedPreferencesKeys.token,
        value: token,
      );
    }

    final bool isFirstLogin = result.data['first_login'];

    return isFirstLogin;
  }

  @override
  Future<User> getOtherUser(id) async {
    final result = await dio.get(
      '/api/users/$id/',
    );

    User user = UserModel.fromJson(result.data);

    return user;
  }

  @override
  Future<User> getUser() async {
    final result = await dio.get(
      '/api/users/self/',
    );

    User user = UserModel.fromJson(result.data);

    return user;
  }

  @override
  Future<User> updateUser(String? username, String? status) async {
    final result = await dio.patch(
      '/api/users/update-username-status/',
      data: {"username": username, "status": status},
    );

    User user = UserModel.fromJson(result.data);

    await sharedPreferencesRepository.writeString(
      key: SharedPreferencesKeys.userId,
      value: user.id.toString(),
    );

    return user;
  }
}
