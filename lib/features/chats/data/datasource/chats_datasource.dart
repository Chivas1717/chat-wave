import 'package:clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';

abstract class ChatsDatasource {
  Future<List<User>> getUsers();
}

class ChatsDatasourceImpl extends ChatsDatasource {
  ChatsDatasourceImpl({
    required this.dio,
    // required this.sharedPreferencesRepository,
  });

  final Dio dio;
  // final SharedPreferencesRepository sharedPreferencesRepository;

  @override
  Future<List<User>> getUsers() async {
    final result = await dio.post(
      '/api/users/?page_size=1200',
    );
    List<User> users = List.from(result.data['results'])
        .map((e) => UserModel.fromJson(e))
        .toList();

    return users;
  }
}
