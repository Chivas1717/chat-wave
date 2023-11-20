import 'package:clean_architecture_template/features/chats/data/models/message_model.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';

class ChatFullModel extends ChatFull {
  ChatFullModel({
    super.id,
    super.messages,
    super.name,
    super.chatPic,
    super.users,
  });

  ChatFullModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messages = List.from(json['messages'])
        .map((e) => MessageModel.fromJson(e))
        .toList();
    name = json['name'];
    chatPic = json['chat_pic'];
    users = List.from(json['users']);
  }
}
