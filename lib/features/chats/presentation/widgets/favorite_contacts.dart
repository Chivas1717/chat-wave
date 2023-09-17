import 'package:clean_architecture_template/features/chats/presentation/screens/main_chats_screen.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class FavoriteContacts extends StatelessWidget {
  const FavoriteContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Favorite contacts",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildContactAvatar('Alla', 'img1.jpeg'),
              buildContactAvatar('July', 'img2.jpeg'),
              buildContactAvatar('Mikle', 'img3.jpeg'),
              buildContactAvatar('Kler', 'img4.jpg'),
              buildContactAvatar('Moane', 'img5.jpeg'),
              buildContactAvatar('Julie', 'img6.jpeg'),
              buildContactAvatar('Allen', 'img7.jpeg'),
              buildContactAvatar('John', 'img8.jpg'),
            ],
          ),
        ),
      ],
    );
  }
}

Padding buildContactAvatar(String name, String filename) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Column(
      children: [
        UserAvatar(
          filename: filename,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    ),
  );
}
