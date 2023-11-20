import 'package:clean_architecture_template/core/helper/images.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserRow extends StatefulWidget {
  final bool isSelected;
  final User user;
  const UserRow({
    super.key,
    required this.isSelected,
    required this.user,
  });

  @override
  State<UserRow> createState() => _UserRowState();
}

class _UserRowState extends State<UserRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(UserAvatars.avatars[1]),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${widget.user.username}',
            style: const TextStyle(color: CColors.black, fontSize: 20),
          ),
          const Spacer(),
          widget.isSelected
              ? const Icon(
                  Icons.check_box_outlined,
                  color: CColors.green,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: CColors.black,
                )
        ],
      ),
    );
  }
}
