import 'package:bloc/bloc.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat_full.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';
import 'package:flutter/widgets.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.repository,
  }) : super(ChatInitial());

  final ChatsRepository repository;

  void getChatById(id) async {
    emit(ChatLoading());

    final chatsResult = await repository.getChatById(id);

    chatsResult.fold(
      (failure) => emit(ChatFailure(message: failure.errorMessage)),
      (chat) => emit(ChatData(chat: chat)),
    );
  }
}
