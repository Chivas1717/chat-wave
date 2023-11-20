import 'package:bloc/bloc.dart';
import 'package:clean_architecture_template/features/chats/domain/entities/chat.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';
import 'package:flutter/widgets.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required this.repository,
  }) : super(ChatsInitial());

  final ChatsRepository repository;

  void createChat(userId) async {
    emit(ChatsLoading());

    final creationResult = await repository.createChat(userId);

    creationResult.fold(
      (failure) => emit(ChatsFailure(message: failure.errorMessage)),
      (users) {
        getChats();
      },
    );
  }

  void getChats() async {
    emit(ChatsLoading());

    final chatsResult = await repository.getChats();

    chatsResult.fold(
      (failure) => emit(ChatsFailure(message: failure.errorMessage)),
      (chats) => emit(ChatsData(chats: chats)),
    );
  }
}
