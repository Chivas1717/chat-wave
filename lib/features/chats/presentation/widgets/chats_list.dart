import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/features/chats/presentation/screens/main_chats_screen.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/chat_row.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 25),
      children: const [
        ChatRow(img: 'img1.jpeg', name: 'Laura', message: 'Hello, how are you'),
        ChatRow(img: 'img2.jpeg', name: 'Kalya', message: 'Hello, how are you'),
        ChatRow(img: 'img3.jpeg', name: 'Mary', message: 'Hello, how are you'),
        ChatRow(img: 'img4.jpg', name: 'Hellen', message: 'Hello, how are you'),
        ChatRow(
            img: 'img5.jpeg', name: 'Louren', message: 'Hello, how are you'),
        ChatRow(img: 'img6.jpeg', name: 'Tom', message: 'Hello, how are you'),
        ChatRow(img: 'img7.jpeg', name: 'Laura', message: 'Hello, how are you'),
      ],
    );
  }
}
