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
            backgroundImage: NetworkImage(
                'https://cdn.britannica.com/05/236505-050-17B6E34A/Elon-Musk-2022.jpg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 20,
          ),
          const Text(
            'name',
            style: TextStyle(color: CColors.black, fontSize: 20),
          ),
          Spacer(),
          widget.isSelected
              ? Icon(
                  Icons.check_box_outlined,
                  color: CColors.green,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: CColors.black,
                )
        ],
      ),
    );
  }
}
