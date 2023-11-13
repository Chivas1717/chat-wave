import 'package:clean_architecture_template/core/helper/type_aliases.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';

abstract class ChatsRepository {
  FutureFailable<List<User>> getUsers();
}
