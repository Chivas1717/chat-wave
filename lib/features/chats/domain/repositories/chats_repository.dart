import 'package:clean_architecture_template/core/helper/type_aliases.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';

abstract class ChatsRepository {
  FutureFailable<List<User>> getUsers();
  FutureFailable<void> createChat(userId);
  FutureFailable<List<Chat>> getChats();
  FutureFailable<ChatFull> getChatById(int id);
}
