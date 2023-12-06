import 'package:clean_architecture_template/features/chats/domain/entities/chat.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/chat_row.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key, required this.chats});
  final List<Chat> chats;

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    print(widget.chats);
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 25),
      children: [
        ...List.generate(
          widget.chats.length,
          (index) => ChatRow(
            img: 'img1.jpeg',
            name: widget.chats[index].users!.length > 0
                ? widget.chats[index].users![0].username!
                : widget.chats[index].users![0].username!,
            message:
                widget.chats[index].lastMessage?.text ?? 'Joined recently...',
            chatId: widget.chats[index].id!,
          ),
        ),
        // ChatRow(img: 'img1.jpeg', name: 'Laura', message: 'Hello, how are you'),
        // ChatRow(img: 'img2.jpeg', name: 'Kalya', message: 'Hello, how are you'),
        // ChatRow(img: 'img3.jpeg', name: 'Mary', message: 'Hello, how are you'),
        // ChatRow(img: 'img4.jpg', name: 'Hellen', message: 'Hello, how are you'),
        // ChatRow(img: 'img5.jpeg', name: 'Lren', message: 'Hello, how are you'),
        // ChatRow(img: 'img6.jpeg', name: 'Tom', message: 'Hello, how are you'),
        // ChatRow(img: 'img7.jpeg', name: 'Laura', message: 'Hello, how are you'),
      ],
    );
  }
}
