import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/message.dart';

class Chat {
  int? id;
  List<User>? users;
  Message? lastMessage;
  Chat({
    this.id,
    this.users,
    this.lastMessage,
  });

  Chat copyWith({
    int? id,
    List<User>? users,
    Message? lastMessage,
  }) {
    return Chat(
      id: id ?? this.id,
      users: users ?? this.users,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
