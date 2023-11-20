class Message {
  int? id;
  int? sender;
  String? senderUsername;
  String? text;
  String? createdAt;
  List<int>? likes;
  int? chat;

  Message({
    this.id,
    this.sender,
    this.senderUsername,
    this.text,
    this.createdAt,
    this.likes,
    this.chat,
  });

  Message copyWith({
    int? id,
    int? sender,
    String? senderUsername,
    String? text,
    String? createdAt,
    List<int>? likes,
    int? chat,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      senderUsername: senderUsername ?? this.senderUsername,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      chat: chat ?? this.chat,
    );
  }
}
