import 'package:clean_architecture_template/features/chats/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    super.id,
    super.sender,
    super.senderUsername,
    super.text,
    super.createdAt,
    super.likes,
    super.chat,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    senderUsername = json['sender_username'];
    text = json['text'];
    createdAt = json['created_at'];
    likes = List.from(json['likes']);
    chat = json['chat'];
  }
}
