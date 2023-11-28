import 'package:bloc/bloc.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/message.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';
import 'package:flutter/widgets.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.repository,
  }) : super(ChatInitial());

  final ChatsRepository repository;

  void getChatById(int id) async {
    emit(ChatLoading());

    final chatsResult = await repository.getChatById(id);

    chatsResult.fold(
      (failure) => emit(ChatFailure(message: failure.errorMessage)),
      (chat) => emit(ChatData(chat: chat)),
    );
  }

  void addMessage(Message message) {
    (state as ChatData).chat.messages?.add(message);
    var chat = (state as ChatData).chat;
    emit(ChatData(chat: chat));
  }

  void likeMessage(Message message) {
    int index;
    for (var i = 0; i < (state as ChatData).chat.messages!.length; i++) {
      if ((state as ChatData).chat.messages![i].id == message.id) {
        index = i;
        (state as ChatData).chat.messages![index] = message;
        var chat = (state as ChatData).chat;
        emit(ChatData(chat: chat));
        break;
      }
    }
  }
}
