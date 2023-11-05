import 'package:clean_architecture_template/core/helper/type_aliases.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  FutureFailable<bool> sendOtp(String email);
  FutureFailable<bool> checkOtp(String phoneNumber, String code);
  FutureFailable<User> getUser();
  FutureFailable<void> logOut();
  FutureFailable<User> getOtherUser(int id);
  FutureFailable<User> updateUser({String? username, String? status});
}
