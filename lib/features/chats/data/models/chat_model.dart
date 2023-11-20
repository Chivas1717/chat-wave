import 'package:clean_architecture_template/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_template/features/chats/data/models/message_model.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    super.id,
    super.users,
    super.lastMessage,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    users = List.from(json['users']).map((e) => UserModel.fromJson(e)).toList();
    lastMessage = json['last_message'] == null
        ? null
        : MessageModel.fromJson((json['last_message']));
  }
}
