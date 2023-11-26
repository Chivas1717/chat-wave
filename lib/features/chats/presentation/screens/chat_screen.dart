import 'dart:convert';

import 'package:clean_architecture_template/core/helper/shared_preferences.dart';
import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/input_decorations.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:clean_architecture_template/features/chats/data/models/message_model.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/message.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/chat/chat_cubit.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chatId,
  }) : super(key: key);
  final int chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late AnimationController chatAnimationController;
  TextEditingController textEditingController = TextEditingController();
  late ChatCubit chatCubit;
  String? text;
  late WebSocketChannel _channel;

  @override
  void initState() {
    chatCubit = sl()..getChatById(widget.chatId);

    SharedPreferencesRepository sharedPreferencesRepository = sl();
    String token = sharedPreferencesRepository.readString(
          key: SharedPreferencesKeys.token,
        ) ??
        "";
    WebSocketChannel channel = IOWebSocketChannel.connect(
        "ws://127.0.0.1:8000/ws/chat/${widget.chatId}/",
        headers: {
          'Authorization': 'Token $token',
        });
    channel.stream.listen((event) {
      if (jsonDecode(event)['type'] == 'chat_message') {
        Message message = MessageModel.fromJson(jsonDecode(event)['message']);
        (chatCubit.addMessage(message));
      }
    });
    _channel = channel;

    chatAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => showChat());
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
        bloc: chatCubit,
        builder: (context, state) {
          if (state is ChatData) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
              child: Scaffold(
                appBar: _CustomAppBar(
                  name: state.chat.name,
                  picture: state.chat.chatPic,
                ),
                backgroundColor: Colors.white,
                body: SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(chatAnimationController),
                  child: Stack(
                    children: [
                      WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [Colors.blue, const Color(0xEEccf9ff)],
                            [Colors.blue[800]!, const Color(0xEE7ce8ff)],
                            [Colors.blue, const Color(0x6655d0ff)],
                            [Colors.blue, const Color(0x5500acdf)]
                          ],
                          durations: [35000, 19440, 10800, 6000],
                          heightPercentages: [-0.07, -0.03, -0.08, -0.05],
                          gradientBegin: Alignment.bottomLeft,
                          gradientEnd: Alignment.topRight,
                        ),
                        size: const Size(double.infinity, double.infinity),
                        waveAmplitude: 0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30.0,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          // borderRadius: const BorderRadius.only(
                          //   topLeft: Radius.circular(50.0),
                          //   topRight: Radius.circular(50.0),
                          // ),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ChatMessages(
                              scrollController: scrollController,
                              chat: state.chat,
                            ),
                            TextFormField(
                              controller: textEditingController,
                              onChanged: (value) {
                                setState(() {
                                  text = value;
                                });
                              },
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: CustomOutlineInputDecoration(
                                  // filled: true,
                                  // fillColor: Theme.of(context)
                                  //     .colorScheme
                                  //     .secondary
                                  //     .withAlpha(150),
                                  // hintText: 'Type here...',
                                  // hintStyle: Theme.of(context).textTheme.bodyMedium,
                                  // // disabledBorder: const OutlineInputBorder(
                                  // //   // width: 0.0 produces a thin "hairline" border
                                  // //   borderSide:
                                  // //       const BorderSide(color: Colors.white, width: 1.0),
                                  // // ),
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(15.0),
                                  //   borderSide:
                                  //       const BorderSide(color: Colors.white, width: 1.0),
                                  // ),
                                  // contentPadding: const EdgeInsets.all(20.0),
                                  // suffixIcon: _buildIconButton(context),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: CColors.error,
            ),
          );
        });
  }

  showChat() {
    chatAnimationController.forward();
  }

  IconButton _buildIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send),
      color: Theme.of(context).iconTheme.color,
      onPressed: () {
        // Message message = Message(
        //   senderId: '1',
        //   recipientId: '2',
        //   text: text,
        //   createdAt: DateTime.now(),
        // );
        // List<Message> messages = List.from(chat.messages!)..add(message);
        // messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        //
        // setState(() {
        //   chat = chat.copyWith(messages: messages);
        // });
        // scrollController.animateTo(
        //   scrollController.position.minScrollExtent,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeIn,
        // );
        // textEditingController.clear();
      },
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    Key? key,
    required this.scrollController,
    required this.chat,
  }) : super(key: key);

  final ScrollController scrollController;
  final ChatFull chat;

  @override
  Widget build(BuildContext context) {
    int me = sl<UserCubit>().state.user.id ?? 0;
    return Expanded(
      child: ListView.builder(
        reverse: false,
        controller: scrollController,
        itemCount: chat.messages!.length,
        itemBuilder: (context, index) {
          Message message = chat.messages![index];
          return Align(
            alignment: (message.sender != me)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color:
                    (message.sender != me) ? Colors.white : Colors.green[300],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                message.text ?? '? error processing message ?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
    required this.name,
    required this.picture,
  }) : super(key: key);

  final String? name, picture;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Column(
        children: [
          Text(
            name ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Online',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundImage: picture != null ? NetworkImage(picture!) : null,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
