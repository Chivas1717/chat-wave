import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';

class UsersUtils {
  List<User> getSortedUsers(List<User> users) {
    for (var user in users) {
      if (user.username == null) {
        throw ArgumentError('username must not be null');
      }
    }
    users.sort((a, b) => a.username!.compareTo(b.username!));
    return users;
  }
}
