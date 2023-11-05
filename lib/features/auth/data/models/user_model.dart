import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    super.username,
    super.profilePic,
    super.status,
    super.phoneNumber,
    super.lastSeen,
    super.online,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilePic = json['profile_pic'];
    status = json['status'];
    phoneNumber = json['phone_number'];
    lastSeen = json['last_seen'];
    online = json['online'];
  }
}
