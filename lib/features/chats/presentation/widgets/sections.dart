import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:flutter/material.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10),
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Messages",
              style: TextStyle(color: CColors.white, fontSize: 26),
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Online",
              style: TextStyle(color: CColors.grey, fontSize: 26),
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Groups",
              style: TextStyle(color: CColors.grey, fontSize: 26),
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "More",
              style: TextStyle(color: CColors.grey, fontSize: 26),
            ),
          ),
          const SizedBox(
            width: 35,
          ),
        ],
      ),
    );
  }
}
