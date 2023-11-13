import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/core/error/repository_request_handler.dart';
import 'package:clean_architecture_template/core/helper/type_aliases.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/data/datasource/chats_datasource.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl extends ChatsRepository {
  final ChatsDatasource chatsDatasource;

  ChatsRepositoryImpl({
    required this.chatsDatasource,
  });

  @override
  FutureFailable<List<User>> getUsers() {
    return RepositoryRequestHandler<List<User>>()(
      request: () => chatsDatasource.getUsers(),
      defaultFailure: IncorrectEmailFailure(),
    );
  }
}
