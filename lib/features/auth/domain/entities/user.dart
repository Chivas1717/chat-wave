class User {
  int? id;
  String? username;
  String? profilePic;
  String? status;
  String? phoneNumber;
  String? lastSeen;
  bool? online;

  User({
    this.id,
    this.username,
    this.profilePic,
    this.status,
    this.phoneNumber,
    this.lastSeen,
    this.online,
  });

  User copyWith({
    int? id,
    String? username,
    String? profilePic,
    String? status,
    String? phoneNumber,
    String? lastSeen,
    bool? online,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePic: profilePic ?? this.profilePic,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lastSeen: lastSeen ?? this.lastSeen,
      online: online ?? this.online,
    );
  }
}
