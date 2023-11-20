import 'package:clean_architecture_template/features/chats/domain/entities/message.dart';

class ChatFull {
  int? id;
  List<int>? users;
  List<Message>? messages;
  String? name;
  String? chatPic;
  ChatFull({this.id, this.users, this.messages, this.name, this.chatPic});

  ChatFull copyWith({
    int? id,
    List<int>? users,
    List<Message>? messages,
    String? name,
    String? chatPic,
  }) {
    return ChatFull(
      id: id ?? this.id,
      users: users ?? this.users,
      messages: messages ?? this.messages,
      name: name ?? this.name,
      chatPic: chatPic ?? this.chatPic,
    );
  }
}
