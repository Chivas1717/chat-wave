import 'package:clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/data/models/chat_full_model.dart';
import 'package:clean_architecture_template/features/chats/data/models/chat_model.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';
import 'package:dio/dio.dart';

abstract class ChatsDatasource {
  Future<List<User>> getUsers();

  Future<void> createChat(int userId);

  Future<List<Chat>> getChats();

  Future<ChatFull> getChatById(int id);
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
    final result = await dio.get(
      '/api/users/?page_size=1200',
    );
    List<User> users = List.from(result.data['results'])
        .map((e) => UserModel.fromJson(e))
        .toList();

    return users;
  }

  @override
  Future<void> createChat(userId) async {
    await dio.post('/api/chats/', data: {
      "user_ids": [userId],
    });

    return;
  }

  @override
  Future<List<Chat>> getChats() async {
    final result = await dio.get('/api/chats/list/');

    List<Chat> chats =
        List.from(result.data).map((e) => ChatModel.fromJson(e)).toList();

    return chats;
  }

  @override
  Future<ChatFull> getChatById(id) async {
    final result = await dio.get('/api/chats/$id/');

    ChatFull chat = ChatFullModel.fromJson(result.data);
    return chat;
  }
}
